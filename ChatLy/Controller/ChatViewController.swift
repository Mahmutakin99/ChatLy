import UIKit
import FirebaseFirestore

private let reuseIdentifier = "MessageCell"

class ChatViewController: UICollectionViewController {
    //MARK: Properties
    var messages = [Message]()
    private lazy var chatInputView = ChatInputView(frame: .init(x: 0, y: 0, width: view.frame.width, height: view.frame.width * 0.2))
    private let user: User
    private var didInitialScrollToBottom = false
    private var messageListener: ListenerRegistration?
    
    //MARK: LifeCycle
    init(user: User) {
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMessages()
        style()
        layout()
        
        collectionView.keyboardDismissMode = .onDrag
        hideKeyboardWhenTappedAround()
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        backgroundTap.cancelsTouchesInView = false
        backgroundTap.delegate = self
        view.addGestureRecognizer(backgroundTap)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override var inputAccessoryView: UIView? {
        get { return chatInputView }
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
        messageListener?.remove()
    }
    
    //MARK: Helpers
    private func style() {
        collectionView.backgroundColor = .systemBlue
        collectionView.register(NewMessageCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        chatInputView.delegate = self
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.title = user.name
        collectionView.alwaysBounceVertical = true
        if let flow = collectionViewLayout as? UICollectionViewFlowLayout {
            flow.estimatedItemSize = .zero
        }
        collectionView.contentInsetAdjustmentBehavior = .never
    }
    private func layout() {
    }
    
    // MARK: Service
    private func fetchMessages() {
        messageListener = Service.fetchMessages(user: user) { [weak self] messages in
            guard let self = self else { return }
            self.messages = messages
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.layoutIfNeeded()
                self.scrollToLastMessage(animated: false)
            }
        }
    }
}

//MARK: UICollectionViewDelegate/DataSource
extension ChatViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NewMessageCell
        cell.message = messages[indexPath.row]
        cell.message?.user = user
        return cell
    }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let fakeCell = NewMessageCell(frame: .init(x: 0, y: 0, width: view.frame.width, height: 50))
        fakeCell.message = messages[indexPath.row]
        fakeCell.layoutIfNeeded()
        let target = CGSize(width: view.frame.width, height: 1000)
        let fakeCellSize = fakeCell.systemLayoutSizeFitting(target)
        return .init(width: view.frame.width, height: fakeCellSize.height)
    }
}

// MARK: ChatInputViewProtocol
extension ChatViewController: ChatInputViewProtocol {
    func sendMessage(_ chatInputView: ChatInputView, message: String) {
        Service.sendMessage(message: message, toUser: user) { error in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                return
            }
        }
        chatInputView.clear()
    }
}

extension ChatViewController: UIGestureRecognizerDelegate {
    @objc private func handleBackgroundTap() {
        view.window?.endEditing(true)
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if let touchedView = touch.view, touchedView.isDescendant(of: chatInputView) { return false }
        return true
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension ChatViewController {
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let baseInset = chatInputView.bounds.height + 5
        var insets = collectionView.contentInset
        if insets.bottom < baseInset { insets.bottom = baseInset }
        collectionView.contentInset = insets
        collectionView.scrollIndicatorInsets = insets
        if !didInitialScrollToBottom && !messages.isEmpty {
            didInitialScrollToBottom = true
            scrollToLastMessage(animated: false)
        }
    }

    private func scrollToLastMessage(animated: Bool) {
        let section = 0
        let itemCount = collectionView.numberOfItems(inSection: section)
        guard itemCount > 0 else { return }
        let lastIndexPath = IndexPath(item: itemCount - 1, section: section)
        collectionView.performBatchUpdates(nil) { [weak self] _ in
            self?.collectionView.scrollToItem(at: lastIndexPath, at: .bottom, animated: animated)
        }
    }

    @objc private func handleKeyboardWillShow(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }

        let kbEndInView = view.convert(keyboardFrame, from: nil)
        let overlap = max(0, view.bounds.maxY - kbEndInView.origin.y)
        var insets = collectionView.contentInset
        insets.bottom = overlap + chatInputView.bounds.height + 5

        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curveRaw << 16), animations: {
            self.collectionView.contentInset = insets
            self.collectionView.scrollIndicatorInsets = insets
            self.scrollToLastMessage(animated: false)
        })
    }

    @objc private func handleKeyboardWillHide(_ notification: Notification) {
        guard
            let userInfo = notification.userInfo,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
            let curveRaw = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
        else { return }

        var insets = collectionView.contentInset
        insets.bottom = chatInputView.bounds.height + 5

        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions(rawValue: curveRaw << 16), animations: {
            self.collectionView.contentInset = insets
            self.collectionView.scrollIndicatorInsets = insets
            self.scrollToLastMessage(animated: false)
        })
    }
}
