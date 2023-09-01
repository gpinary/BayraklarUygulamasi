//
//  QuizEkraniViewController.swift
//  BayrakApp
//
//  Created by Gökçe Pınar Yıldız on 1.09.2023.
//

import UIKit

class QuizEkraniViewController: UIViewController {

    @IBOutlet weak var labelDogru: UILabel!
    @IBOutlet weak var labelYanlis: UILabel!
    
    @IBOutlet weak var labelSoruSayisi: UILabel!
    @IBOutlet weak var imageViewBayrak: UIImageView!
    
    @IBOutlet weak var butonA: UIButton!
    @IBOutlet weak var butonB: UIButton!
    @IBOutlet weak var butonC: UIButton!
    @IBOutlet weak var butonD: UIButton!
    
    var sorular = [Bayraklar]()
    var yanlisSecenekler = [Bayraklar]()
    
    var dogruSoru = Bayraklar()
    
    var soruSayac = 0
    var dogruSayac = 0
    var yanlisSayac = 0
    
    var secenekler = [Bayraklar]()
    var seceneklerKaristirmaListesi = Set <Bayraklar>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sorular = Bayraklardao().rastgele5Getir()
        
        for s in sorular {
            print(s.bayrak_ad!)
        }
        soruYukle()

       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gidilecekVC = segue.destination as! SonucEkraniViewController
        gidilecekVC.dogruSayisi = dogruSayac
    }
    
    func soruYukle(){
        labelSoruSayisi.text = "\(soruSayac+1). SORU"
        labelDogru.text = "Doğru: \(dogruSayac)"
        labelYanlis.text = "Yanlış: \(yanlisSayac)"
        
        dogruSoru = sorular[soruSayac]
        
        imageViewBayrak.image = UIImage(named: dogruSoru.bayrak_resim!)
        
        yanlisSecenekler = Bayraklardao().rastgeleYanlisSecenekGetir(bayrak_id: dogruSoru.bayrak_id!)
        
        seceneklerKaristirmaListesi.removeAll()
        
        seceneklerKaristirmaListesi.insert(dogruSoru)
        seceneklerKaristirmaListesi.insert(yanlisSecenekler[0])
        seceneklerKaristirmaListesi.insert(yanlisSecenekler[1])
        seceneklerKaristirmaListesi.insert(yanlisSecenekler[2])
        
        secenekler.removeAll()
        
        for s in seceneklerKaristirmaListesi {
            secenekler.append(s)
        }
        
        butonA.setTitle(secenekler[0].bayrak_ad, for: .normal)
        butonB.setTitle(secenekler[1].bayrak_ad, for: .normal)
        butonC.setTitle(secenekler[2].bayrak_ad, for: .normal)
        butonD.setTitle(secenekler[3].bayrak_ad, for: .normal)

    }
    
    func dogruKontrol(button:UIButton) {
        let buttonYazi = button.titleLabel?.text
        let dogruCevap = dogruSoru.bayrak_ad
        
        print("Buton Yazi: \(buttonYazi!)")
        print("Dogru Cevap: \(dogruCevap!)")
        
        if dogruCevap == buttonYazi {
            dogruSayac += 1
        }else{
            yanlisSayac += 1
        }
        
        labelDogru.text = "Doğru: \(dogruSayac)"
        labelYanlis.text = "Yanlış: \(yanlisSayac)"
    }
    func soruSayacKontrol(){
        soruSayac += 1
        
        if soruSayac != 5 {
            soruYukle()
        }else{
            performSegue(withIdentifier: "toSonucEkrani", sender: nil)
        }
    }
    @IBAction func butonATikla(_ sender: Any) {
        dogruKontrol(button: butonA)
        soruSayacKontrol()
    }
    
    @IBAction func butonBTikla(_ sender: Any) {
        dogruKontrol(button: butonB)
        soruSayacKontrol()
    }
    
    @IBAction func butonCTikla(_ sender: Any) {
        dogruKontrol(button: butonC)
        soruSayacKontrol()
    }
    
    @IBAction func butonDTikla(_ sender: Any) {
        dogruKontrol(button: butonD)
        soruSayacKontrol()
    }
    
    
    
}
