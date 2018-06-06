package com.wondersgroup.test.input;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.HttpStatus;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.params.HttpMethodParams;

public class Test {

	public static void main(String[] args) throws IOException {
		/*
		 * erpInputBatchDetail erp企业增加进货台账 
		 */
		String urlString="http://101.231.159.180/fdWebCompany/webservice/erpInputBatchDetail";
		Map map=new HashMap<String, String>();
		map.put("appID", "2020");
		map.put("companyID", "1ace892");
		map.put("key", "11e5a56a");
		map.put("content", "{supplier:{supName:'麦德龙餐饮供应有限公司12',supAddress:'上海闽行区1538',supCateringCert:'沪餐证字2016ee2313145231',supFoodBusinessCert:'JY201605e2131452',supFoodCircuCert:'SP20wew52313145230',supFoodProdCert:'SC201605qq131452',supBizCertNum:'201607231314523',supCode:'1002',supNameAbbrev:'麦德龙',supContactPerson:'李鲜花',supContactPhone:'13112345678'},material:[{name:'酱油',spec:'8瓶',manufacture:'青岛XX有限公司',guaranteeValue:'1',guaranteeUnit:'年',typeGeneral:'9001',code:'1503',nameEn:'EDF',placeOfProduction:'青岛'}],batchDetail:[{recordDate:'2016-08-03',materialName:'酱油',manufacture:'青岛XX有限公司',spec:'8瓶',quantity:'50',productionDate:'2015-08-22',productionBatch:'23233',code:'上海丰收日餐饮有限公司',traceCode:'32233'}]}");
		post(urlString,map);
		
		/*
		 * erpInputBatchDetail erp企业增加配送台账
		 */
		urlString="http://101.231.159.180/fdWebCompany/webservice/erpOutputBatchDetail";
		map.clear();
		map.put("appID", "2020");
		map.put("companyID", "1ace892");
		map.put("key", "11e5a56a");
		map.put("content", "{receiver:{recName:'ZXCCCCCCCCCC',recAddress:'上海市静安区',recCateringCert:'沪餐证字2016012313aa5231',recFoodBusinessCert:'JY10160523a31452',recFoodCircuCert:'SP101605f313145230',recFoodProdCert:'SC101ww523131452',recBizCertNum:'101605231314qq3',recCode:'',recNameAbbrev:'丰收日',recContactPerson:'刘老汉',recContactPhone:'13112345678'},material:[{name:'酱油4',spec:'4瓶',manufacture:'青岛XX有限公司',guaranteeValue:'1',guaranteeUnit:'年',typeGeneral:'9002',code:'1033',nameEn:'EDF',placeOfProduction:'青岛'}],batchDetail:[{recordDate:'2016-05-23',materialName:'酱油4',manufacture:'青岛XX有限公司',spec:'4瓶',quantity:'50',productionDate:'2015-08-22',productionBatch:'23233',code:'上海丰收日餐饮有限公司',traceCode:'32233'}]}");
		//post(urlString,map);
		
		/*
		 * uploadImage 上传企业证照图片，如果证件图片已经存在，不会覆盖已有证照，须该企业自行维护，图片须转成BASE64字符串
		 */
		File f = new File("D://icon_ewm.jpg");
		int size = (int) f.length();
		byte[] b = new byte[size];
		BufferedInputStream in = new BufferedInputStream(new FileInputStream(f));
		in.read(b);
		String imgString = net.iharder.base64.Base64.encodeBytes(b);
		
		urlString="http://101.231.159.180/fdWebCompany/webservice/uploadImage";
		map.clear();
		map.put("appID", "2020");
		map.put("key", "11e5a56a");
		map.put("companyID", "1ace892");
		map.put("content", "{type:'COM_SPSCXKZ',number:'SC33106090309011',expDate:'2016-09-15'}");//证照类型，证照号码，到期日期
		map.put("image", imgString);//图片base64转码字符串
		//post(urlString,map);
	}

	public static void post(String URL,Map<String,String> params) throws IOException {
		HttpClient client = new HttpClient();
		PostMethod postMethod = new PostMethod(URL);
		try {
			//传递参数
			if (params != null && !params.isEmpty()) {
				for (Map.Entry<String, String> entry : params.entrySet()) {
					postMethod.addParameter(entry.getKey(),entry.getValue());
				}
			}
			//设置utf-8编码
			postMethod.getParams().setParameter(HttpMethodParams.HTTP_CONTENT_CHARSET,"utf-8");
			int statusCode = client.executeMethod(postMethod);
			if (statusCode != HttpStatus.SC_OK) {
				System.err.println("Method failed: "
						+ postMethod.getStatusLine());
			}
			/* 获得返回的结果 */
			byte[] responseBody = postMethod.getResponseBody();
			System.out.println(new String(responseBody));
		} catch (HttpException e) {
			System.err.println("Fatal protocol violation: " + e.getMessage());
			e.printStackTrace();
		} catch (IOException e) {
			System.err.println("Fatal transport error: " + e.getMessage());
			e.printStackTrace();
		} finally {
			/* Release the connection. */
			postMethod.releaseConnection();
		}
	}
	
	public static void get(String backUrl, Map<String, Object> params)
			throws UnsupportedEncodingException {
		StringBuffer stringBuffer = new StringBuffer();
		if (params != null && !params.isEmpty()) {
			for (Map.Entry<String, Object> entry : params.entrySet()) {
				stringBuffer.append(entry.getKey()).append("=")
						.append(entry.getValue()).append("&");
			}
		}
		stringBuffer.deleteCharAt(stringBuffer.length() - 1);
		System.out.println("-->>" + stringBuffer.toString());
		HttpURLConnection conn = null;
		BufferedReader read = null;
		try {

			URL url = new URL(backUrl+"?"+stringBuffer.toString());
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.connect();
			read = new BufferedReader(new InputStreamReader(
					conn.getInputStream()));
			StringBuffer sb = new StringBuffer();
			String line = "";
			while ((line = read.readLine()) != null) {
				sb.append(line);
			}
			System.out.println("回调响应的数据为:" + sb.toString());

		} catch (Exception e) {

			e.printStackTrace();
		} finally {
			try {
				if (read != null) {
					read.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			if (conn != null) {
				conn.disconnect();
			}
		}
	}
}
