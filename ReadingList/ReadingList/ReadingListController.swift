import UIKit

class ReadingListController: UITableViewController
{
    @IBOutlet var dataSource: BookDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.load()
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier ?? "" {
        case "View":
            guard let detailController = segue.realDestination as? BookViewing,
                let indexPath = tableView.indexPathForSelectedRow else {
                    fatalError("View Book controller must conform to the BookViewing protocol")
            }
            detailController.book = dataSource.book(at: indexPath)
        case "Add":
            guard let addController = segue.realDestination as? BookEditing else {
                fatalError("Add Book controller must conform to the BookEditing protocol")
            }
            addController.completion = { [weak self] book in self?.dataSource.insert(book: book) }
        default:
            fatalError("Unknown segue identifier: \(segue.identifier ?? "null")")
        }
    }
}

// MARK: - Unwind Segues
extension ReadingListController
{
    @IBAction func doneEditing(segue: UIStoryboardSegue) { dataSource.save() }
    @IBAction func doneAdding(segue: UIStoryboardSegue) { }
    @IBAction func cancelAdding(segue: UIStoryboardSegue) { }
}

// TODO: Migrate to another class.
//
// MARK: - UITableViewDataSource
//extension ReadingListController
//{
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return readingList.books.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookSummary") else {
//            fatalError("Unable to dequeue cell with identifier \"BookSummary\". Make sure identifier is correctly set in storyboard.")
//        }
//        let book = readingList.books[indexPath.row]
//        cell.textLabel?.text = book.title
//        cell.detailTextLabel?.text = "\(book.year ?? "   ") \(book.author?.fullName ?? "Unknown")"
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            readingList.books.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            store.save(readingList: readingList)
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        let book = readingList.books[sourceIndexPath.row]
//        readingList.books.remove(at: sourceIndexPath.row)
//        readingList.books.insert(book, at: destinationIndexPath.row)
//        tableView.moveRow(at: sourceIndexPath, to: destinationIndexPath)
//        store.save(readingList: readingList)
//    }
//}

// MARK: - Another version of UITableViewDataSource
extension ReadingListController
{
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 100 // FIXME: !!!
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookSummary") else {
//            fatalError("Unable to dequeue cell with identifier \"BookSummary\". Make sure identifier is correctly set in storyboard.")
//        }
//        cell.detailTextLabel?.text = "Row \(indexPath.row + 1)"
//        return cell
//    }
}

// MARK: - Earlier version of UITableViewDataSource
extension ReadingListController
{
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableView.dequeueReusableCell(withIdentifier: "Foo") ??
////            UITableViewCell(style: .subtitle, reuseIdentifier: "Foo")
//
//        var cell: UITableViewCell
//
//        if let reusedCell = tableView.dequeueReusableCell(withIdentifier: "Foo") {
//            cell = reusedCell
//        } else {
//            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Foo")
////            cell.textLabel?.text = "Row \(indexPath.row + 1)"
//        }
//
//        cell.textLabel?.text = "Row \(indexPath.row + 1)"
//        return cell
//    }
}
