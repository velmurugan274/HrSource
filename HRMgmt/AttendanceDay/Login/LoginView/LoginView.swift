//
import UIKit

class LoginView: UIViewController, LoginViewProtocol {
    func updatedEmpUuid(empUuid: String) {
        self.empUuid = empUuid
    }
    
    func validatedUserID(checkUserID: Bool) {
        self.checkUserId = checkUserID
    }
    
    func validatedPassword(checkPassword: Bool) {
        self.checkPassword = checkPassword
    }
    var empUuid : String?
    var presenter : LoginPresenterProtocol?
    var checkUserId : Bool?
    var checkPassword : Bool?
    var userId : UITextField = {
        let useId = UITextField()
        useId.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        useId.text = "8667391809"
        useId.placeholder = "emailId / Phone Number"
        useId.translatesAutoresizingMaskIntoConstraints = false
        useId.textAlignment = .center
        useId.layer.borderColor = UIColor.gray.cgColor
        useId.autocapitalizationType = .none
        useId.layer.borderWidth = 0.5
      //  useId.backgroundColor = .white
        useId.layer.cornerRadius = 25
        return useId
    }()
    let password : UITextField = {
        let pwd = UITextField()
        pwd.backgroundColor = UIColor(red: 60/255.0, green: 116/255.0, blue: 255/255.0, alpha: 0.1)
        pwd.text = "admin"
        pwd.placeholder = "password"
        pwd.translatesAutoresizingMaskIntoConstraints = false
        pwd.textAlignment = .center
        pwd.layer.borderColor = UIColor.gray.cgColor
      //  pwd.backgroundColor = .white
        pwd.autocapitalizationType = .none
        pwd.isSecureTextEntry = true
        pwd.layer.borderWidth = 0.5
        pwd.layer.masksToBounds = true
        pwd.layer.cornerRadius = 25
        return pwd
    }()
    
    let loadingView : UIImageView = {
        let gif = UIImageView()
        gif.loadGif(name: "loading")
        gif.contentMode = .scaleAspectFit
        gif.isHidden = true
        return gif
    }()
    let whiteback : UIView = {
        let view  = UIView()
        view.backgroundColor = .white
        view.alpha = 0.5
        view.isHidden = true
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginImage.alpha = 01
        userId.alpha = 0.0
        enter.alpha = 0.0
        password.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 1.8, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.loginImage.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 1.8, delay: 1.2, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.userId.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 1.8, delay: 1.4, options: .curveEaseOut, animations: {
            self.password.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 1.8, delay: 1.6, options: .curveEaseOut, animations: {
            self.enter.alpha = 1
        }, completion: nil)
        
    }
    
    
    
    let enter : UIButton = {
        let ent = UIButton()
        ent.translatesAutoresizingMaskIntoConstraints=false
        ent.setTitleColor(.white , for: .normal)
        ent.setTitle("Login" , for: .normal)
        ent.backgroundColor = UIColor(red: 0.0/255.0, green: 56/255.0, blue: 110/255.0, alpha: 1)
        ent.layer.masksToBounds = true
        ent.layer.cornerRadius = 25
        return ent
    }()
    
    let loginImage = UIImageView(image: UIImage(named: "loginpage"))
//    let login = loginController()
    var scrollView :  UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LoginRouter.createLoginModule(loginRef: self)
        view.backgroundColor = .white
        loginImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.contentSize = view.frame.size
        scrollView.addSubview(loginImage)
        scrollView.addSubview(userId)
        scrollView.addSubview(password)
        scrollView.addSubview(enter)
        scrollView.addSubview(whiteback)
        scrollView.addSubview(loadingView)
        
        scrollView.isScrollEnabled = true
        enter.addTarget(self, action: #selector(pressButton(button:)), for: .touchUpInside)
        scrollView.backgroundColor = UIColor(red: 137/255.0, green: 196/255.0, blue: 244/255.0, alpha: 0.2)
        scrollView.backgroundColor = .clear
        setConstrains()
        hideKeyboardWhenTappedAround()
        
    }
    
    func  setConstrains(){
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive=true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive=true;
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive=true;
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        loginImage.topAnchor.constraint(equalTo: scrollView.topAnchor,constant :120).isActive=true
        loginImage.leftAnchor.constraint(equalTo: view.leftAnchor,constant : 70).isActive=true;
        loginImage.rightAnchor.constraint(equalTo: view.rightAnchor,constant : -70).isActive=true;
        loginImage.heightAnchor.constraint(equalToConstant: 120).isActive=true;
        
        userId.topAnchor.constraint(equalTo: loginImage.bottomAnchor,constant :50).isActive=true
        userId.leftAnchor.constraint(equalTo: view.leftAnchor,constant : 30).isActive=true;
        userId.rightAnchor.constraint(equalTo: view.rightAnchor,constant : -30).isActive=true;
        userId.heightAnchor.constraint(equalToConstant: 50).isActive=true;
        
        password.topAnchor.constraint(equalTo: userId.bottomAnchor,constant : 20).isActive=true
        password.leftAnchor.constraint(equalTo: view.leftAnchor,constant : 30).isActive=true;
        password.rightAnchor.constraint(equalTo: view.rightAnchor,constant : -30).isActive=true;
        password.heightAnchor.constraint(equalToConstant: 50).isActive=true;
        
        enter.topAnchor.constraint(equalTo: password.bottomAnchor,constant : 20).isActive=true
        enter.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        enter.widthAnchor.constraint(equalToConstant: 100).isActive = true
        enter.heightAnchor.constraint(equalToConstant: 50).isActive=true;
        whiteback.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
        
        loadingView.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 120, bottom: 0, right: 120), size: CGSize(width: 0, height: 80))
        loadingView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard), name: UIResponder.keyboardWillHideNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard), name: UIResponder.keyboardWillChangeFrameNotification , object: nil)
        scrollView.contentSize = CGSize(width: view.frame.width, height: 800)
    }
    @objc func keyboard(notification: Notification){
        let userInfo = notification.userInfo!
        let keyboardScreenEndFrame = ((userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue))?.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame!, to: view.window)
        if notification.name == UIResponder.keyboardWillHideNotification{
            scrollView.contentInset = UIEdgeInsets.zero
        }else{
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (keyboardViewEndFrame.height), right: 0)
        }
        scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    
    
    @objc func pressButton(button : UIButton){
        
        presenter?.validateUserID(userID: userId.text!)
        presenter?.validatePassword(password: password.text!)
        
        if userId.text == "" || password.text == "" {
            
            showToast(message: "Enter login credentials")
            
        } else if password.text == "" {
            
            showToast(message: "Enter password")
            
            
        } else if checkUserId! == false {

            userId.text = ""
            password.text  = ""
            showToast(message: "Enter Valid UserID")

        } else if checkPassword! == false {

            password.text = ""
            showToast(message: "Enter Valid Password")
            
        } else {
            print("Yes1")
//            let progressHUD = ProgressHUD(text: "Logging in..")
//            view.addSubview(progressHUD)
            loadingView.isHidden = false
            whiteback.isHidden = false
            presenter?.getEmpUuid(usedId: userId.text!)
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.presenter?.presentHomeTab(from : self, with: self.empUuid!)
            }
            
        }

        
        
        
        
       
    }
}

