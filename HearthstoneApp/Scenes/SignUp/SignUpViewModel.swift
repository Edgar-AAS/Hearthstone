import Foundation

class SignUpViewModel: SignUpViewModelProtocol {
    private let addAccount: AddAccountProtocol
    private let emailValidator: EmailValidatorProtocol
    private weak var alertView: AlertViewProtocol?
    private let coordinator: Coordinator
    private var isLogged: Bool = false
    
    init(addAccount: AddAccountProtocol,
         alertView: AlertViewProtocol,
         emailValidator: EmailValidatorProtocol,
         coordinator: Coordinator) {
        
        self.addAccount = addAccount
        self.alertView = alertView
        self.emailValidator = emailValidator
        self.coordinator = coordinator
    }
    
    func registerUserWith(userRequest: RegisterUserRequest) {
        if let message = validateFields(userRequest: userRequest) {
            alertView?.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            addAccount.signUp(with: userRequest) { [weak self] isRegistered, error in
                self?.isLogged = isRegistered
                if isRegistered {
                    self?.alertView?.showMessage(viewModel: AlertViewModel(title: "Sucesso", message: "Conta Criada!"))
                } else {
                    self?.alertView?.showMessage(viewModel: AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em instantes"))
                }
            }
        }
    }
    
    func routeSignUpToLogin() {
        if isLogged {
            coordinator.eventOcurred(type: .popCurrentController)
        }
    }
    
    private func validateFields(userRequest: RegisterUserRequest) -> String? {
        if userRequest.username == "" || userRequest.username == nil {
            return "O campo de Nome do usuário é obrigatório"
        } else if userRequest.email == "" || userRequest.email == nil {
            return "O campo de E-mail é obrigatório"
        } else if !emailValidator.isValid(email: userRequest.email ?? "") {
            return "O campo de E-mail esta inválido"
        } else if userRequest.password == "" || userRequest.password == nil {
            return "O campo de Senha é obrigatório"
        } else if userRequest.passwordConfirmation == "" || userRequest.passwordConfirmation == nil {
            return "O campo de Confirmação de senha é obrigatório"
        } else if userRequest.password != userRequest.passwordConfirmation {
            return "Não foi possível confirmar senha"
        } else { return nil }
    }
}
