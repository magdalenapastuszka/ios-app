import Foundation

final class MenuViewModel {
    @Published var menuRows: [MenuListData] = []
    
    private var logOut: (() -> Void)?
    
    init(logOut: @escaping () -> Void) {
        self.logOut = logOut
        configure()
    }
    
    func loadModel() -> MenuView.Model {
        MenuView.Model(
            name: "James Bond",
            email: "james@007.com"
        )
    }
    
    private func configure() {
        menuRows = [
            .init(key: .main, values: [
                .main(MenuListTableViewCell.Model(
                    image: .menuEvents,
                    title: "menu.events".localized,
                    textColor: .textColor,
                    action: {}
                )),
                .main(MenuListTableViewCell.Model(
                    image: .menuFinance,
                    title: "menu.finance".localized,
                    textColor: .placeholderColor,
                    action: nil
                )),
                .main(MenuListTableViewCell.Model(
                    image: .menuCRM,
                    title: "menu.crm".localized,
                    textColor: .placeholderColor,
                    action: nil
                )),
                .main(MenuListTableViewCell.Model(
                    image: .menuSales,
                    title: "menu.sales".localized,
                    textColor: .placeholderColor,
                    action: nil
                )),
                .main(MenuListTableViewCell.Model(
                    image: .menuInsights,
                    title: "menu.insights".localized,
                    textColor: .placeholderColor,
                    action: nil
                )),
                .main(MenuListTableViewCell.Model(
                    image: .menuSettings,
                    title: "menu.settings".localized,
                    textColor: .placeholderColor,
                    action: nil
                )),
                .main(MenuListTableViewCell.Model(
                    image: .logout,
                    title: "menu.logout".localized,
                    textColor: .logoutColor,
                    action: logOut
                )),
            ])
        ]
    }
}
