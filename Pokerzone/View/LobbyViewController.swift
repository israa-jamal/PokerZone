//
//  ViewController.swift
//  Pokerzone
//
//  Created by Esraa Gamal on 07/01/2022.
//

import Cocoa
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

class LobbyViewController: NSViewController {
    
    //MARK: Outlets
    
    @IBOutlet weak var loginButton: NSButton!
    @IBOutlet weak var tableViewContainer: NSView!
    @IBOutlet weak var column :NSTableColumn!
    @IBOutlet weak var tableView :NSTableView!
    @IBOutlet weak var backGround: NSView!
    @IBOutlet weak var gameTextView: NSView!
    @IBOutlet weak var limitTextView: NSView!
    @IBOutlet weak var buyInTextView: NSView!
    @IBOutlet weak var avgTextView: NSView!
    @IBOutlet weak var gameTextField: NSTextField!
    @IBOutlet weak var limitTextField: NSTextField!
    @IBOutlet weak var buyInTextField: NSTextField!
    @IBOutlet weak var avgTextField: NSTextField!
    @IBOutlet weak var clearButton: NSButton!
    @IBOutlet weak var mainBox: NSBox!
    
    //MARK: Proprites
    
    let viewModel = LobbyViewModel()
    lazy var textFields = [gameTextField, limitTextField, buyInTextField, avgTextField]
    
    //MARK: Object Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.prepareDataSource()
        configureUI()
        
        viewModel.gameData.subscribe { [weak self] gameDataArray in
            guard let self = self else {return}
            self.tableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    //MARK: UI
    
    func configureUI() {
        let arr = [gameTextView, buyInTextView, avgTextView, limitTextView]
        column.headerCell.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        backGround.wantsLayer = true
        backGround.layer?.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.2039215686, blue: 0.4470588235, alpha: 1)
        tableViewContainer.wantsLayer = true
        tableViewContainer.layer?.backgroundColor = #colorLiteral(red: 0.08235294118, green: 0.1450980392, blue: 0.3098039216, alpha: 1)
        clearButton.wantsLayer = true
        clearButton.layer?.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.1843137255, blue: 0.4392156863, alpha: 0.99)
        clearButton?.layer?.cornerRadius = 3
        
        arr.forEach { nsView in
            nsView?.wantsLayer = true
            nsView?.layer?.backgroundColor = #colorLiteral(red: 0.2, green: 0.2470588235, blue: 0.4196078431, alpha: 0.39)
            nsView?.layer?.cornerRadius = 3
        }
        textFields.forEach { textField in
            textField?.delegate = self
        }
    }
    
    //MARK: Actions
    
    @IBAction func loginButtonTapped(_ sender: NSButton) {
        let loginVC =  self.storyboard?.instantiateController(withIdentifier: "loginVC") as! LoginPopUp
        present(loginVC, animator: ModalAnimator())
    }
    
    @IBAction func clearButtonTapped(_ sender: NSButton) {
        textFields.forEach { textField in
            textField?.stringValue = ""
        }
        viewModel.gameData.accept(viewModel.mainData.value)
    }
}

//MARK:- NSTableView

extension LobbyViewController : NSTableViewDelegate, NSTableViewDataSource  {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel.gameData.value.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let tableColumn = tableColumn, let column = tableView.tableColumns.firstIndex(of: tableColumn) {
            let cellData = getDataForCell(column:column, row: row)
            if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: cellData.0?.description ?? ""), owner: nil) as? NSTableCellView {
                if column == 10 {
                    cell.imageView?.image = NSImage(named: cellData.1 ?? "")
                } else {
                    if let font = NSFont(name: "Axiforma-Medium", size: 11){
                        cell.textField?.attributedStringValue = NSAttributedString(string: cellData.1 ?? "", attributes: [NSAttributedString.Key.foregroundColor : NSColor.white , NSAttributedString.Key.font : font])
                    }
                }
                return cell
            }
        }
        
        return nil
    }
    
    func tableViewSelectionDidChange(_ notification: Notification) {
        let rows = tableView.selectedRowIndexes
        var array = viewModel.mainData.value
        for row in rows {
            array[row].isFavorite = !array[row].isFavorite
        }
        viewModel.mainData.accept(array)
        viewModel.gameData.accept(viewModel.mainData.value)
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 32
    }
    
    //MARK: Helpers
    
    func getDataForCell(column: Int, row: Int) -> (CellIdentifiers?, String?){
        guard let cellIdentifer = CellIdentifiers(rawValue: column) else { return (nil, nil)}
        var value = ""
        let gameData = viewModel.gameData.value[row]
        switch cellIdentifer {
        case .TableName:
            value = gameData.tableName
        case .Game:
            value = gameData.gameName
        case .Stakes:
            value = gameData.Stakes
        case .BuyIn:
            value = "\(gameData.buyIn)"
        case .Seats:
            value = "\(gameData.seats)"
        case .Players:
            value = "\(gameData.players)"
        case .Waitlist:
            value = "\(gameData.waitlist)"
        case .Avg:
            value = "\(gameData.avg)"
        case .FloopSeen:
            value = "\(gameData.floopSeen)"
        case .Hands_Hr:
            value = "\(gameData.hands_Hr)"
        case .Favorite:
            value = gameData.isFavorite ? "filledStar" : "emptyStar"
        }
        return (cellIdentifer, value)
    }
    
}

//MARK:- NSTextFieldDelegate

extension LobbyViewController : NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        if let textField = obj.object as? NSTextField{
            if textField == gameTextField {
                viewModel.gameData.accept(viewModel.mainData.value.filter({textField.stringValue == "" ? true : $0.gameName.contains(textField.stringValue)}))
            } else if textField == limitTextField {
                viewModel.gameData.accept(viewModel.mainData.value.filter({textField.stringValue == "" ? true : $0.Stakes.contains(textField.stringValue)}))
            } else if textField == buyInTextField {
                viewModel.gameData.accept(viewModel.mainData.value.filter({textField.stringValue == "" ? true : $0.buyIn.contains(textField.stringValue)}))
            } else if textField == avgTextField {
                viewModel.gameData.accept(viewModel.mainData.value.filter({textField.stringValue == "" ? true : $0.avg.contains(textField.stringValue)}))
            }
        }
    }
}
