//
//  ViewController.swift
//  WeatherUpdate
//
//  Created by Md. Faysal Ahmed on 25/11/22.
//

// MARK: - If this API doesn't work please update StoreData.swift from JSON link

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
    
    @IBOutlet weak var uvValue: UILabel!
    @IBOutlet weak var uvInWord: UILabel!
    @IBOutlet weak var uvProgress: UIProgressView!
    @IBOutlet weak var uvProgressInWord: UILabel!
    
    @IBOutlet weak var sunrise: UILabel!
    @IBOutlet weak var sunset: UILabel!
    
    @IBOutlet weak var windMPH: UILabel!
    @IBOutlet weak var west: UILabel!
    @IBOutlet weak var east: UILabel!
    @IBOutlet weak var north: UILabel!
    @IBOutlet weak var south: UILabel!
    
    @IBOutlet weak var rainfall: UILabel!
    @IBOutlet weak var rainfallExpectation: UILabel!
    
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var feelsInWord: UILabel!
    
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var dewPointer: UILabel!
    
    @IBOutlet weak var visibility: UILabel!
    @IBOutlet weak var pressure: UILabel!
        
    var forecastday = [Forecastday]()
    var hourArr = [Hour]()
    var days = ["Fri", "Sat", "Sun", "Mon", "Tue", "Wed", "Thu"]
    var selectedDays = [String]()
    var todaysIndex = 0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUIView()
        dayDetails()
        setupTableView()
        setupCollectionView()
        getData()
        
        print("hhh")
    }
    
    
    // MARK: - Private Methods.
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
            todaysIndex = index
        }
        
        for i in 0..<7 {
            selectedDays.append(days[(todaysIndex+i) % 7])
        }

        print("------------------ ", dayInWeek)
    }
    

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
    
    
    // MARK: - URLSesion
    private func getData() {
        
        let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=8a1f9ffaa74a4b3d85f62252223103&q=Dhaka&days=10&aqi=no&alerts=no")

        // Use URLSession to make a network request to the API
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil && data != nil {
                
                do {
                    guard let data = data else { return }
                    let decoder = JSONDecoder()
                    let weather = try decoder.decode(Welcome.self, from: data)
                    
                    DispatchQueue.main.async {
                        print(weather.forecast.forecastday[0].date)
                        
                        // HEADER
                        self.location.text = "\(weather.location.name)"
                        self.country.text = "\(weather.location.country)"
                        self.highTemp.text = "H: \(Int(weather.forecast.forecastday[0].day.maxtempF))°"
                        self.lowTemp.text = "L: \(Int(weather.forecast.forecastday[0].day.mintempF))°"
                        self.fahrenheit.text = "\(Int(weather.current.tempF))°"
                        
                        // Current day temperature
                        self.hourArr = weather.forecast.forecastday[0].hour
                        self.collectionVieww.reloadData()
                        
                        // Next 3 days forecast
                        let days = weather.forecast.forecastday
                        self.forecastday = days
                        self.tableVieww.reloadData()
                        
                        // UVValue
                        self.uvValue.text = "\(weather.current.uv)"
                        self.uvProgress.setProgress( Float(Double(weather.current.uv) / 11.0), animated: true)
                        if weather.current.uv >= 6 {
                            self.uvInWord.text = "HIGH"
                            self.uvProgressInWord.text = "High for the rest of the day."
                        }
                        
                        // Sunrise/Sunset
                        self.sunrise.text = "\(days[0].astro.sunrise)"
                        self.sunset.text = "\(days[0].astro.sunset)"
                        
                        // Wind
                        self.windMPH.text = "\(weather.current.windMph)"
                        let windDir = "\(days[0].hour[0].windDir)"
                        self.north.text = "- N"
                        if windDir.last == "e" { self.east.text = "E ->" }
                        else { self.west.text = "<- W" }
                        
                        // Rainfall
                        self.rainfall.text = "\(Float(days[0].day.totalprecipMm))''"
                        if days[0].day.totalprecipMm > 1 {self.rainfallExpectation.text="Expected in next 3 days."}
                        
                        // Weather feels
                        self.feelsLike.text = "\(weather.current.feelslikeF)°"
                        if weather.current.feelslikeC <= 28 { self.feelsInWord.text = "Humidity is making it feel cooler." }
                        
                        // Humidity/Dewpointer
                        self.humidity.text = "\(weather.current.humidity)%"
                        self.dewPointer.text = "The dew point is \(days[0].hour[0].dewpointF.toString())° right now."

                        // Visibility / Pressure
                        self.visibility.text = "\(weather.current.visMiles) mi"
                        self.pressure.text = "\(weather.current.pressureMB)\nmbar"
                        
                    }
                    
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }
        }.resume()
        
        
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
        
        let time = hourArr[indexPath.row].time
        cell.time.text = getTime(time, 13, -5)
        cell.fareheit.text = String(Int(hourArr[indexPath.row].tempF)) + "°"
        
        return cell
    }
    
    
    func getTime(_ time: String, _ startOffset: Int, _ endOffset: Int) -> String {
        let endIdx = time.index(time.startIndex, offsetBy: 13)
        let startIdx = time.index(time.endIndex, offsetBy: -5)
        
        return String(time[startIdx..<endIdx])
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



// MARK: - collectionViewFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 70, height: 160)
    }
    
}


