//
//  GWHTTPTool.swift
//  JiulingCentro_Swift
//
//  Created by 魏郭文 on 16/6/27.
//  Copyright © 2016年 魏郭文. All rights reserved.
//

import UIKit
struct NetMangaer {

    static let netError = "网络异常，请检查网络"
    //首页
    static let rollingURL = WebUrl + kRollingUrl
    static let newGoodsURL = WebUrl + kNewGoodsDataUrl
    static let recommendShopURL = kRecommendShopUrl
    
    //商品详情页
    static let GoodDetailURL = WebUrl + kGoodsDetailUrl
    
    //久零商城页
    static let leftViewURL = WebUrl + kCentreLeftViewUrl
    
    
/***********************首页***************************/
    
    //请求轮播图的数据
    static func requestRollingCellData( resultClosure:(Bool,[AdvertisingModel]!) -> Void) {

        NetMangaer.GET(rollingURL, parameters: nil, showHUD: false, success: { (responseObject) -> Void in
            var advertyArray = [AdvertisingModel]()
            if let dict = responseObject as? [String:NSObject], dic = dict["data"] as? [String:NSObject], array = dic["list"] as? [[String:NSObject]] {
                for d in array {
                    advertyArray.append(AdvertisingModel(dict: d))
                }
            }
            resultClosure(true,advertyArray)
            
            }) { (error) -> Void in
                resultClosure(false,nil)
        }
    }
   
    //请求联盟商家的数据
    static func requestLmstoreCellData(city:String, resultCloure:(Bool,[LmStoreList]!) -> Void)
    {
        NetMangaer.POST(recommendShopURL, parameters:["city":city], showHUD: false, success: { (responseObject) -> Void in
            
            var lmStoreArray = [LmStoreList]()
            if let dictionary = responseObject as? [String:NSObject], responDict = dictionary["data"] as? [String:NSObject], array = responDict["store"] as? [[String:NSObject]]
            {
                for dictionary in array
                {
                    lmStoreArray.append(LmStoreList.init(dict: dictionary))
                }
            }
            resultCloure(true,lmStoreArray)
            
            }) { (error) -> Void in
                resultCloure(false,nil)
        }
    }

    //请求最新商品的数据
    static func requestNewGoodsCellData(resultCloure:(Bool,[MainList]!) -> Void)
    {
        NetMangaer.GET(newGoodsURL, parameters: nil, showHUD: false, success: { (responseObject) -> Void in
            
            var newGoodsArray = [MainList]()
            if let dict = responseObject as? [String:NSObject], dataDict = dict["data"] as? [String:NSObject],listArray = dataDict["list"] as? [[String:NSObject]] {
                
                for dic in listArray
                {
                    newGoodsArray.append(MainList(dict: dic))
                }
            }
            resultCloure(true,newGoodsArray)
            
            }) { (error) -> Void in
                resultCloure(false,nil)
        }
    }
    /***********************首页***************************/

    /***********************Common页***************************/
    static func requestGoodsDetailData(goods_id:String, resultCloure:(Bool,[String:NSObject]!) -> Void)
    {
        let URL = GoodDetailURL + goods_id
        NetMangaer.GET(URL, parameters: nil, showHUD: false, success: { (reponseObject) -> Void in
            let dict = reponseObject as! [String:NSObject]
            resultCloure(true,dict["data"] as! [String:NSObject])
        }) { (error) -> Void in
            resultCloure(false,nil)
        }
    }
     
    /***********************Common页***************************/
    
    /***********************Centre页***************************/
    //抽屉的数据
    static func requestLeftViewData(resuleCloure:(Bool,[MainList]!) ->Void)
    {
        NetMangaer.GET(leftViewURL, parameters: nil, showHUD: false, success: { (responseObject) -> Void in
                let dictionary = responseObject as! [String:NSObject]
            let data = dictionary["data"] as! [String:AnyObject]
            let list = data["list"] as! [[String:AnyObject]]
            var tempArray = [MainList]()
            for dic in list{
                tempArray.append(MainList.init(dict: dic))
            }
            resuleCloure(true,tempArray)
            }) { (error) in
                resuleCloure(false,nil)
        }
    }
    
    //主页数据
    static func requestCentreListData(classID:String,order:String,page:Int,resultCloure:(Bool,[MainList]!) -> Void){
        let url = WebUrl + "goods/?act=index&ClassID=\(classID)&Page=\(page)&Order=\(order)"
        GET(url, parameters: nil, success: { (responseObject) in
            let dictionary = responseObject as? [String:AnyObject]
            var tempArray = [MainList]()
            if let data = dictionary!["data"] as? [String:AnyObject],let list = data["list"] as? [[String:AnyObject]] {
                for dict in list
                {
                    tempArray.append(MainList.init(dict: dict))
                }
            }
            resultCloure(true,tempArray)
        }) { (error) in
            resultCloure(false,nil)
        }
    }
    
    /***********************Centre页***************************/
    
    //GET
    static func GET(URLString:String, parameters:[String:NSObject]?, showHUD:Bool = true, success:((NSObject?) -> Void)?, failure:((NSError) -> Void)?) {
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10
        if showHUD {
            MBProgressHUD.showHUDAddedTo(MainWindow, animated: true)
        }
        
        manager.GET(URLString, parameters: parameters, progress: nil, success: { (task, responseObject) -> Void in
            
            if showHUD {
                MBProgressHUD.hideAllHUDsForView(MainWindow, animated: true)
            }
            
            success?(responseObject as? NSObject)
            
        }) { (task, error) -> Void in
            if showHUD {
                MBProgressHUD.hideAllHUDsForView(MainWindow, animated: true)
                MainWindow?.makeToast(netError)
            }
            failure?(error)
        }
    }
    
    //POST
    static func POST(URLString:String, parameters:[String:NSObject]?, showHUD:Bool = true, success:((NSObject?) -> Void)?, failure:((NSError) -> Void)?) {
        
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.timeoutInterval = 10;
        if showHUD {
            MBProgressHUD.showHUDAddedTo(MainWindow, animated: true)
        }
        
        manager.POST(URLString, parameters: parameters, progress: nil, success: { (task, responseObject) -> Void in
            
            if showHUD {
                MBProgressHUD.hideAllHUDsForView(MainWindow, animated: true)
            }
            
            success?(responseObject as? NSObject)
            
            }) { (task, error) -> Void in
                
                if showHUD {
                    MBProgressHUD.hideAllHUDsForView(MainWindow, animated: true)
                    MainWindow?.makeToast(netError)
                }
                failure?(error)
        }
    }
}
