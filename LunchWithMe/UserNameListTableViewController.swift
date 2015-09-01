//
//  UserNameListTableViewController.swift
//  LunchWithMe
//
//  Created by zeus on 01/09/15.
//  Copyright (c) 2015 disco. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class UserNameListTableViewController: UITableViewController, MCSessionDelegate, MCNearbyServiceBrowserDelegate {
    
    let serviceType = "LunchWithMe"
    
    var userName: String = ""
    
    var assistant : MCAdvertiserAssistant!
    var session : MCSession!
    var peerID: MCPeerID!
    
    var mybrowser: MCNearbyServiceBrowser!
    
    var listOfPeers: [String] = []
    var listOfConnectedPeers: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.peerID = MCPeerID(displayName: userName)
        
        self.session = MCSession(peer: peerID)
        self.session.delegate = self
        
        self.assistant = MCAdvertiserAssistant(serviceType:serviceType,
            discoveryInfo:nil, session:self.session)
        
        // tell the assistant to start advertising our fabulous chat
        self.assistant.start()
        
        self.mybrowser = MCNearbyServiceBrowser(peer: self.peerID, serviceType: serviceType)
        self.mybrowser.delegate = self
        self.mybrowser.startBrowsingForPeers()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
                
//        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "showBrowser:"), animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.listOfPeers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userNameCellIdentifier", forIndexPath: indexPath) as! UITableViewCell
        
        let buddyName = listOfPeers[indexPath.row]
        
        cell.textLabel?.text = buddyName

        return cell
    }
    
    // MARK: Browse Delegates
    func browser(browser: MCNearbyServiceBrowser!, foundPeer peerID: MCPeerID!, withDiscoveryInfo info: [NSObject : AnyObject]!) {
        
        listOfPeers.append(peerID.displayName)

        dispatch_async(dispatch_get_main_queue()) {
            
            self.tableView.reloadData()
        }
        
    }
    
    func browser(browser: MCNearbyServiceBrowser!, lostPeer peerID: MCPeerID!) {

    }
    
    func browser(browser: MCNearbyServiceBrowser!, didNotStartBrowsingForPeers error: NSError!) {
        
    }

    // MARK: - Peer
    
    func session(session: MCSession!, didReceiveData data: NSData!,
        fromPeer peerID: MCPeerID!)  {
            // Called when a peer sends an NSData to us
            
    }
    
    // The following methods do nothing, but the MCSessionDelegate protocol
    // requires that we implement them.
    func session(session: MCSession!,
        didStartReceivingResourceWithName resourceName: String!,
        fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!)  {
            
            // Called when a peer starts sending a file to us
    }
    
    func session(session: MCSession!,
        didFinishReceivingResourceWithName resourceName: String!,
        fromPeer peerID: MCPeerID!,
        atURL localURL: NSURL!, withError error: NSError!)  {
            // Called when a file has finished transferring from another peer
    }
    
    func session(session: MCSession!, didReceiveStream stream: NSInputStream!,
        withName streamName: String!, fromPeer peerID: MCPeerID!)  {
            // Called when a peer establishes a stream with us
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!,
        didChangeState state: MCSessionState)  {
            
            if state == MCSessionState.Connected {
                self.listOfConnectedPeers.append(peerID.displayName)
                dispatch_async(dispatch_get_main_queue()) {
                    
                    self.tableView.reloadData()
                }
            }
    }


}
