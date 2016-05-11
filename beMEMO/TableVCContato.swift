//
//  TableVCContato.swift
//  beMEMO
//
//  Created by Samuel Dias Fernandes de Oliveira on 09/05/16.
//  Copyright © 2016 samueldfo. All rights reserved.
//

import UIKit

class TableVCContato: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var ContatoTableView: UITableView! //outlet tablet view
    
    var data:[Contato] = [Contato]() //declara array Contato
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //customização do navigation menu
        self.navigationItem.title = "Contato" //titulo
        self.navigationController?.navigationBar.barTintColor = (UIColor(red: 219.0/255.0, green: 200.0/255.0, blue: 168.0/255.0, alpha: 1.0)) //cor do fundo
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black // cor do texto do status bar - branco
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()] // cor do título
        
        // chama a func loaddata
        loadData()
        
        //ativa o scroll de acordo a quantidade de itens
        if (ContatoTableView.contentSize.height < ContatoTableView.frame.size.height) {
            ContatoTableView.scrollEnabled = false;
        }
        else {
            ContatoTableView.scrollEnabled = true;
        }
    
        // remove cell vazia da tableview
        ContatoTableView.tableFooterView = UIView()
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Carregar info das células da TableView
    func loadData() -> [Contato] {
    
        data.append(Contato(name:"sitedabememo.com.br",imageName:"web"))
        data.append(Contato(name:"facebememo",imageName:"facebook"))
        data.append(Contato(name:"bememo_",imageName:"instagram"))
        data.append(Contato(name:"snapdabememo",imageName:"snapchat"))
        data.append(Contato(name:"canaldabememo",imageName:"youtube"))
        data.append(Contato(name:"bememo",imageName:"pinterest"))
        data.append(Contato(name:"emaildabememo@gmail.com",imageName:"mail"))
        data.append(Contato(name:"(11) 9824-0039",imageName:"phone"))
    
        return data
        
    }
    
    // define a quantidade de celulas pelo tamanho da array
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    // criar as células do tableview
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ContatoCell", forIndexPath: indexPath)
        let Contato = data[indexPath.row]
        
        cell.textLabel?.text = Contato.name //carrega nome da array
        cell.imageView?.image = Contato.image //carrega imagem da array
        //cell.textLabel?.font = UIFont.italicSystemFontOfSize(18) //fonte italic e tamanho da fonte
        //cell.textLabel?.textColor = UIColor(red: 145.0/255.0, green: 145.0/255.0, blue: 145.0/255.0, alpha: 1.0) //cor de celula
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator //setinha indicator
        cell.separatorInset = UIEdgeInsetsZero //linha de separacao abaixo da imagem
        
        return cell
    }
    
    
    //define a altura das celula
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 55.0;
    }
    
    //chama as segue

    var indicecell : Int = Int()
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        indicecell = indexPath.row
        
        switch indexPath.row{
        case 0: self.performSegueWithIdentifier("websegue", sender: self)
        break;
        case 1: self.performSegueWithIdentifier("websegue", sender: self);
        break;
        case 2: self.performSegueWithIdentifier("websegue", sender: self);
        break;
        case 3: self.performSegueWithIdentifier("websegue", sender: self);
        break;
        case 4: self.performSegueWithIdentifier("websegue", sender: self);
        break;
        case 5: self.performSegueWithIdentifier("websegue", sender: self);
        break;
        case 6: self.performSegueWithIdentifier("mail", sender: self);
        break;
        case 7: self.performSegueWithIdentifier("phone", sender: self);
        break;
        default:
            break
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if (segue.identifier == "websegue") {
            
            let webViewController = segue.destinationViewController as! WebViewController
            
            switch indicecell{
            case 0:
                webViewController.url = NSURL(string: "https://www.google.com.br")
                break;
            case 1:
                webViewController.url = NSURL(string: "https://www.facebook.com/facebememo/?fref=ts")
                break;
            case 2:
                webViewController.url = NSURL(string: "https://www.instagram.com/bememo_/")
                break;
            case 3:
                webViewController.url = NSURL(string: "https://www.snapchat.com")
                break;
            case 4:
                webViewController.url = NSURL(string: "https://www.youtube.com.br")
                break;
            case 5:
                webViewController.url = NSURL(string: "https://br.pinterest.com/")
                break;
            default:
                break
            }
        }
        
    }
}
    
    

    
    
