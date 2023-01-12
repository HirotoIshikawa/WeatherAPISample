//
//  ViewController.swift
//  WeatherAPISample
//
//  Created by 石川寛人 on 2023/01/11.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var publishingOffice: UITextView!
    
    @IBOutlet weak var reportDatetime: UITextView!
    
    @IBOutlet weak var targetArea: UITextView!
    
    @IBOutlet weak var text: UITextView!
    
    @IBOutlet weak var requestButton: UIButton!
    
    var jsonMap: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // ボタンタップ時の挙動
    @IBAction func clickRequestBtn() {
        // 非同期実行
        Task {
            // APIから情報取得
            let res = await getWeatherData()
            // UIの更新はメインスレッドで実行
            DispatchQueue.main.async {
                self.publishingOffice.text = res?.publishingOffice
                self.targetArea.text = res?.targetArea
                self.reportDatetime.text = res?.reportDatetime
                self.text.text = res?.text
            }
        }
    }
    
    /**
     気象庁APIを叩く
     */
    func getWeatherData() async -> WeatherResponse? {
        
        // 今回叩くAPIのURL
        let url: URL = URL(string: "https://www.jma.go.jp/bosai/forecast/data/overview_forecast/130000.json")!
        
        do {
            // urlResponseには、httpStatus(200,403)などが入っている
            // urlResponseで成功時、タイムアウト時、サーバーエラー時など切り分けができる
            // dataにはAPIの返却値（JSON）が入っている
            
            // APIを叩く
            let (data, urlResponse) = try await URLSession.shared.data(from: url, delegate: nil)
            
            // Jsonをデコードして構造体に格納
            let model = try JSONDecoder().decode(WeatherResponse.self, from: data)
            
            return model
        } catch {
            // エラー時
            print("apiでエラー")
            return nil
        }
    }
}

