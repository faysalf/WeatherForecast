//
//  ViewController.swift
//  WeatherUpdate
//
//  Created by Md. Faysal Ahmed on 25/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var fahrenheit: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!

    @IBOutlet weak var collectionVieww: UICollectionView!
    @IBOutlet weak var tableVieww: UITableView!
    
    @IBOutlet weak var viewOfCollectionView: UIView!
    @IBOutlet weak var viewOfTableView: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    @IBOutlet weak var view7: UIView!
    @IBOutlet weak var view8: UIView!
    
    
    
    var rest = RestManager()
    
    var forecastday = [Forecastday]()
    
    var hourArr = [Hour]()
    var days = ["Fri", "Sat", "Sun", "Mon", "Tue", "Wed", "Thu"]
    var selectedDays = [String]()
    var todayIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUIView()
        dayDetails()
        setupTableView()
        setupCollectionView()
        getData()
        
        print("hhh")
    }
    
    
    func setUIView() {
        let arr = [viewOfCollectionView, viewOfTableView, view1, view2, view3, view4, view5, view6, view7, view8]
        for i in arr {
            i?.layer.cornerRadius = 15
        }
    }
    
    func dayDetails() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        let dayInWeek = dateFormatter.string(from: date)
        
        if let index = days.firstIndex(of: dayInWeek) {
            todayIndex = index
        }
        
        for i in 0..<3 {
            selectedDays.append(days[(todayIndex+i) % 7])
        }

        print("------------------ ", dayInWeek)
    }

    // MARK: - Private Methods.
    
    func setupTableView() {
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableVieww.register(nib, forCellReuseIdentifier: "cell")
        tableVieww.dataSource = self
        tableVieww.separatorColor = UIColor.black
    }
    
    func setupCollectionView() {
        let cvNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionVieww.register(cvNib, forCellWithReuseIdentifier: "cell")
        collectionVieww.dataSource = self
    }
    
    private func getData() {
        
        guard let url = URL(string: Api.weatherApiUrl) else { return }
        rest.makeRequest(toURL: url, withHttpMethod: .get) { result in
                        
            guard let data = result.data else { return }
            
            let decoder = JSONDecoder()
            let weather = try? decoder.decode(Welcome.self, from: data)
            
            guard let dayy = weather?.forecast.forecastday else { return }
            
            self.forecastday = dayy
            self.hourArr = dayy[0].hour
            
            print("-----", weather)

            DispatchQueue.main.async { [self] in
                location.text = weather?.location.name
                country.text = weather?.location.country
                fahrenheit.text = "\(Int((weather?.current.tempF)!))°"
                lowTemp.text = "L: \(Int(round(forecastday[0].day.mintempF)))°"
                highTemp.text = "H:\(Int(round(forecastday[0].day.maxtempF)))°"

                self.collectionVieww.reloadData()
                self.tableVieww.reloadData()
            }
        }
    }
}


// MARK: - CollectionView DataSource

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return hourArr.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        let str = hourArr[indexPath.row].time
        let endIdx = str.index(str.startIndex, offsetBy: 13)
        let startIdx = str.index(str.endIndex, offsetBy: -5)

        cell.time.text = String(str[startIdx..<endIdx])
        cell.fareheit.text = String(Int(hourArr[indexPath.row].tempF)) + "°"
        
        return cell
    }
}


// MARK: - TableView DataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(forecastday.count, 3)
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        
        cell.minTemp.text = (forecastday[indexPath.row].day.mintempF.toString()) + "°"
        cell.maxTemp.text = (forecastday[indexPath.row].day.maxtempF.toString()) + "°"
        
        let progValue = forecastday[indexPath.row].day.mintempF
        cell.progressBar.setProgress(Float(progValue)/100, animated: true)
        
        cell.day.text = self.selectedDays[indexPath.row]
        if indexPath.row == 0 { cell.day.text = "Today"}
        
        return cell
    }
    
}

extension Double {
    func toString() -> String {
        return String(format: "%.0f",self)
    }
}



// MARK: - collectionViewFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 70, height: 160)
    }
}

