
/*
 Threading aynı anda birden fazla işi yapabilme kapasitesidir
 */

import UIKit

class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var data = Data()
    var changeImage = 0
    
    let urlString = ["https://upload.wikimedia.org/wikipedia/commons/3/3f/Fronalpstock_big.jpg","https://cdn.wallpapersafari.com/91/67/tGIkTx.jpg"]
    //    let urlString = ["https://upload.wikimedia.org/wikipedia/commons/3/3f/Fronalpstock_big.jpg","https://vastphotos.com/files/uploads/photos/10556/lake-landscape-photo-l.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        print("sdfdsfdsf")
        
        //görsel link ile indirmenin en kötü yolu kesinlikle tavsiye edilmez
        //         data = try! Data(contentsOf: URL(string: urlString[changeImage])!)
        //        imageView.image = UIImage(data: data)
        
        //hala tavsiye edilmez ..
        DispatchQueue.global().async {
            self.data = try! Data(contentsOf: URL(string: self.urlString[self.changeImage])!)
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data)
            }
        }
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshButton))
    }
    
    @objc func refreshButton(){
        
        if changeImage == 0 {
            changeImage = 1
        }else{
            changeImage = 0
        }
        DispatchQueue.global().async {
            self.data = try! Data(contentsOf: URL(string: self.urlString[self.changeImage])!)
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: self.data)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Threading Text"
        return cell
    }
    
}



