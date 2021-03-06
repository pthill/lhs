package com.weixin;

import com.ejavashop.core.freemarkerutil.DomainUrlUtil;

public class CommonConstants {

    /** 
     * 在公众平台里面：开发者ID，应用ID，在基本配置里面 APPID
     */
    public static String APPID               = "wx34d73af9880fd859";

    /**
     * 在公众平台里面：商户号
     */
    public static String MCHID               = "1262228601";

    /**
     * 在公众平台里面：在基本配置里面，应用秘钥，APPSecret
     */
    public static String APPSECRET           = "5e6b4469c6e538d4b13024e12638bf67";

    /**
     * 商户平台里面：商户支付密钥Key。审核通过后，在微信发送的邮件中查看
     */
    public static String KEY                 = "flgxwcwgz20150806123456789012345";

    /**
     * 异步回调地址
     */
    public static String NOTIFY_URL          = DomainUrlUtil.EJS_URL_RESOURCES + "/wx/notify.html";

    /**
     * 生成二维码数据的连接two-dimensional code data
     */
    public static String CREATEORDERURL      = "https://api.mch.weixin.qq.com/pay/unifiedorder";

    /**
     * 虚拟商品价
     */
    public static String VIRTUALPRODUCTPRICE = "1000";

}
