//
//  ViewController.swift
//  WeatherUpdate
//
//  Created by Md. Faysal Ahmed on 25/11/22.
//

// MARK: - Due to third party JSON, change this file if API doesn't work. From: "https://api.weatherapi.com/v1/forecast.json?key=8a1f9ffaa74a4b3d85f62252223103&q=Dhaka&days=10&aqi=no&alerts=no"

import Foundation

// MARK: - Welcome
class Welcome: Codable {
    let location: Location
    let current: Current
    let forecast: Forecast

    init(location: Location, current: Current, forecast: Forecast) {
        self.location = location
        self.current = current
        self.forecast = forecast
    }
}

// MARK: - Current
class Current: Codable {
    let lastUpdatedEpoch: Int
    let lastUpdated: String
    let tempC, tempF: Double
    let isDay: Int
    let condition: Condition
    let windMph, windKph: Double
    let windDegree: Int
    let windDir: WindDir
    let pressureMB: Int
    let pressureIn: Double
    let precipMm, precipIn, humidity, cloud: Int
    let feelslikeC, feelslikeF: Double
    let visKM, visMiles, uv: Int
    let gustMph: Double
    let gustKph: Int

    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case uv
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
    }

    init(lastUpdatedEpoch: Int, lastUpdated: String, tempC: Double, tempF: Double, isDay: Int, condition: Condition, windMph: Double, windKph: Double, windDegree: Int, windDir: WindDir, pressureMB: Int, pressureIn: Double, precipMm: Int, precipIn: Int, humidity: Int, cloud: Int, feelslikeC: Double, feelslikeF: Double, visKM: Int, visMiles: Int, uv: Int, gustMph: Double, gustKph: Int) {
        self.lastUpdatedEpoch = lastUpdatedEpoch
        self.lastUpdated = lastUpdated
        self.tempC = tempC
        self.tempF = tempF
        self.isDay = isDay
        self.condition = condition
        self.windMph = windMph
        self.windKph = windKph
        self.windDegree = windDegree
        self.windDir = windDir
        self.pressureMB = pressureMB
        self.pressureIn = pressureIn
        self.precipMm = precipMm
        self.precipIn = precipIn
        self.humidity = humidity
        self.cloud = cloud
        self.feelslikeC = feelslikeC
        self.feelslikeF = feelslikeF
        self.visKM = visKM
        self.visMiles = visMiles
        self.uv = uv
        self.gustMph = gustMph
        self.gustKph = gustKph
    }
}

// MARK: - Condition
class Condition: Codable {
    let text: Text
    let icon: Icon
    let code: Int

    init(text: Text, icon: Icon, code: Int) {
        self.text = text
        self.icon = icon
        self.code = code
    }
}

enum Icon: String, Codable {
    case cdnWeatherapiCOMWeather64X64Day113PNG = "//cdn.weatherapi.com/weather/64x64/day/113.png"
    case cdnWeatherapiCOMWeather64X64Night113PNG = "//cdn.weatherapi.com/weather/64x64/night/113.png"
}

enum Text: String, Codable {
    case clear = "Clear"
    case sunny = "Sunny"
}

enum WindDir: String, Codable {
    case ene = "ENE"
    case n = "N"
    case ne = "NE"
    case nne = "NNE"
    case nnw = "NNW"
    case nw = "NW"
    case wnw = "WNW"
}

// MARK: - Forecast
class Forecast: Codable {
    let forecastday: [Forecastday]

    init(forecastday: [Forecastday]) {
        self.forecastday = forecastday
    }
}

// MARK: - Forecastday
class Forecastday: Codable {
    let date: String
    let dateEpoch: Int
    let day: Day
    let astro: Astro
    let hour: [Hour]

    enum CodingKeys: String, CodingKey {
        case date
        case dateEpoch = "date_epoch"
        case day, astro, hour
    }

    init(date: String, dateEpoch: Int, day: Day, astro: Astro, hour: [Hour]) {
        self.date = date
        self.dateEpoch = dateEpoch
        self.day = day
        self.astro = astro
        self.hour = hour
    }
}

// MARK: - Astro
class Astro: Codable {
    let sunrise, sunset, moonrise, moonset: String
    let moonPhase, moonIllumination: String

    enum CodingKeys: String, CodingKey {
        case sunrise, sunset, moonrise, moonset
        case moonPhase = "moon_phase"
        case moonIllumination = "moon_illumination"
    }

    init(sunrise: String, sunset: String, moonrise: String, moonset: String, moonPhase: String, moonIllumination: String) {
        self.sunrise = sunrise
        self.sunset = sunset
        self.moonrise = moonrise
        self.moonset = moonset
        self.moonPhase = moonPhase
        self.moonIllumination = moonIllumination
    }
}

// MARK: - Day
class Day: Codable {
    let maxtempC, maxtempF, mintempC, mintempF: Double
    let avgtempC, avgtempF, maxwindMph, maxwindKph: Double
    let totalprecipMm, totalprecipIn, totalsnowCM, avgvisKM: Int
    let avgvisMiles, avghumidity, dailyWillItRain, dailyChanceOfRain: Int
    let dailyWillItSnow, dailyChanceOfSnow: Int
    let condition: Condition
    let uv: Int

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case avgtempC = "avgtemp_c"
        case avgtempF = "avgtemp_f"
        case maxwindMph = "maxwind_mph"
        case maxwindKph = "maxwind_kph"
        case totalprecipMm = "totalprecip_mm"
        case totalprecipIn = "totalprecip_in"
        case totalsnowCM = "totalsnow_cm"
        case avgvisKM = "avgvis_km"
        case avgvisMiles = "avgvis_miles"
        case avghumidity
        case dailyWillItRain = "daily_will_it_rain"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyWillItSnow = "daily_will_it_snow"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case condition, uv
    }

    init(maxtempC: Double, maxtempF: Double, mintempC: Double, mintempF: Double, avgtempC: Double, avgtempF: Double, maxwindMph: Double, maxwindKph: Double, totalprecipMm: Int, totalprecipIn: Int, totalsnowCM: Int, avgvisKM: Int, avgvisMiles: Int, avghumidity: Int, dailyWillItRain: Int, dailyChanceOfRain: Int, dailyWillItSnow: Int, dailyChanceOfSnow: Int, condition: Condition, uv: Int) {
        self.maxtempC = maxtempC
        self.maxtempF = maxtempF
        self.mintempC = mintempC
        self.mintempF = mintempF
        self.avgtempC = avgtempC
        self.avgtempF = avgtempF
        self.maxwindMph = maxwindMph
        self.maxwindKph = maxwindKph
        self.totalprecipMm = totalprecipMm
        self.totalprecipIn = totalprecipIn
        self.totalsnowCM = totalsnowCM
        self.avgvisKM = avgvisKM
        self.avgvisMiles = avgvisMiles
        self.avghumidity = avghumidity
        self.dailyWillItRain = dailyWillItRain
        self.dailyChanceOfRain = dailyChanceOfRain
        self.dailyWillItSnow = dailyWillItSnow
        self.dailyChanceOfSnow = dailyChanceOfSnow
        self.condition = condition
        self.uv = uv
    }
}

// MARK: - Hour
class Hour: Codable {
    let timeEpoch: Int
    let time: String
    let tempC, tempF: Double
    let isDay: Int
    let condition: Condition
    let windMph, windKph: Double
    let windDegree: Int
    let windDir: WindDir
    let pressureMB: Int
    let pressureIn: Double
    let precipMm, precipIn, humidity, cloud: Int
    let feelslikeC, feelslikeF, windchillC, windchillF: Double
    let heatindexC, heatindexF, dewpointC, dewpointF: Double
    let willItRain, chanceOfRain, willItSnow, chanceOfSnow: Int
    let visKM, visMiles: Int
    let gustMph, gustKph: Double
    let uv: Int

    enum CodingKeys: String, CodingKey {
        case timeEpoch = "time_epoch"
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case windMph = "wind_mph"
        case windKph = "wind_kph"
        case windDegree = "wind_degree"
        case windDir = "wind_dir"
        case pressureMB = "pressure_mb"
        case pressureIn = "pressure_in"
        case precipMm = "precip_mm"
        case precipIn = "precip_in"
        case humidity, cloud
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case windchillC = "windchill_c"
        case windchillF = "windchill_f"
        case heatindexC = "heatindex_c"
        case heatindexF = "heatindex_f"
        case dewpointC = "dewpoint_c"
        case dewpointF = "dewpoint_f"
        case willItRain = "will_it_rain"
        case chanceOfRain = "chance_of_rain"
        case willItSnow = "will_it_snow"
        case chanceOfSnow = "chance_of_snow"
        case visKM = "vis_km"
        case visMiles = "vis_miles"
        case gustMph = "gust_mph"
        case gustKph = "gust_kph"
        case uv
    }

    init(timeEpoch: Int, time: String, tempC: Double, tempF: Double, isDay: Int, condition: Condition, windMph: Double, windKph: Double, windDegree: Int, windDir: WindDir, pressureMB: Int, pressureIn: Double, precipMm: Int, precipIn: Int, humidity: Int, cloud: Int, feelslikeC: Double, feelslikeF: Double, windchillC: Double, windchillF: Double, heatindexC: Double, heatindexF: Double, dewpointC: Double, dewpointF: Double, willItRain: Int, chanceOfRain: Int, willItSnow: Int, chanceOfSnow: Int, visKM: Int, visMiles: Int, gustMph: Double, gustKph: Double, uv: Int) {
        self.timeEpoch = timeEpoch
        self.time = time
        self.tempC = tempC
        self.tempF = tempF
        self.isDay = isDay
        self.condition = condition
        self.windMph = windMph
        self.windKph = windKph
        self.windDegree = windDegree
        self.windDir = windDir
        self.pressureMB = pressureMB
        self.pressureIn = pressureIn
        self.precipMm = precipMm
        self.precipIn = precipIn
        self.humidity = humidity
        self.cloud = cloud
        self.feelslikeC = feelslikeC
        self.feelslikeF = feelslikeF
        self.windchillC = windchillC
        self.windchillF = windchillF
        self.heatindexC = heatindexC
        self.heatindexF = heatindexF
        self.dewpointC = dewpointC
        self.dewpointF = dewpointF
        self.willItRain = willItRain
        self.chanceOfRain = chanceOfRain
        self.willItSnow = willItSnow
        self.chanceOfSnow = chanceOfSnow
        self.visKM = visKM
        self.visMiles = visMiles
        self.gustMph = gustMph
        self.gustKph = gustKph
        self.uv = uv
    }
}

// MARK: - Location
class Location: Codable {
    let name, region, country: String
    let lat, lon: Double
    let tzID: String
    let localtimeEpoch: Int
    let localtime: String

    enum CodingKeys: String, CodingKey {
        case name, region, country, lat, lon
        case tzID = "tz_id"
        case localtimeEpoch = "localtime_epoch"
        case localtime
    }

    init(name: String, region: String, country: String, lat: Double, lon: Double, tzID: String, localtimeEpoch: Int, localtime: String) {
        self.name = name
        self.region = region
        self.country = country
        self.lat = lat
        self.lon = lon
        self.tzID = tzID
        self.localtimeEpoch = localtimeEpoch
        self.localtime = localtime
    }
}
