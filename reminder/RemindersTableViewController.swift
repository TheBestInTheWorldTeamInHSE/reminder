//
//  RemindersTableViewController.swift
//  reminder
//
//  Created by Aleksa on 16.07.2020.
//  Copyright © 2020 Владислав Вечерковский. All rights reserved.
//

import UIKit

class RemindersTableViewController: UITableViewController {
    
    var objects = [
    Emoji(emoji: "🤡", name: "clown", description: "u'r a clown", isFavourite: false),
    Emoji(emoji: "🥇", name: "medal", description: "u'r a winner", isFavourite: false),
    Emoji(emoji: "💗", name: "love", description: "it's a joke", isFavourite: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Reminder"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        
        guard segue.identifier == "saveSegue" else {return}
        let sourceViewController = segue.source as! NewEmojiTableViewController
        let emoji = sourceViewController.emoji
        
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            objects[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .fade)
        } else {
        let newIndexPath = IndexPath(row: objects.count, section: 0)
        objects.append(emoji)
        tableView.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "editEmoji" else {return}
        
        let indexPath = tableView.indexPathForSelectedRow!
        let emoji = objects[indexPath.row]
        let navigationViewController = segue.destination as! UINavigationController
        let newEmojiViewController = navigationViewController.topViewController as! NewEmojiTableViewController
        newEmojiViewController.emoji = emoji
        newEmojiViewController.title = "Edit"
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {return 1}
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return objects.count}
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        let object = objects[indexPath.row]

        cell.set(object: object)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {return.delete}
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {return true}
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "done") { (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "checkmark.circle")
        return action
    }
    
    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "like") { (action, view, completion) in
            object.isFavourite = !object.isFavourite
            self.objects[indexPath.row] = object
            completion(true)
        }
        action.backgroundColor = object.isFavourite ? .systemPink : .systemGray
        action.image = UIImage(systemName: "heart")
        return action
    }
}
