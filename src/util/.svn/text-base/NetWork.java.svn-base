package util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.SocketTimeoutException;
import java.net.URL;

public class NetWork {

	private HttpURLConnection mConnection;
	private Object mLock = new Object();
	
	public NetWork(){
		
	}
	
	public String requestHttp(String urlStr){
		String result = "";
		int cnt = 0;
		
		synchronized (mLock) {
			try{
				do{
					try{
						URL url = new URL(urlStr);
						mConnection = (HttpURLConnection) url.openConnection();
						mConnection.setConnectTimeout(5000);
						mConnection.setReadTimeout(4000);
						mConnection.setUseCaches(false);
						
						mConnection.connect();
						if(mConnection.getResponseCode() == HttpURLConnection.HTTP_OK){
							InputStream is = mConnection.getInputStream();
							InputStreamReader in = new InputStreamReader(is, "utf-8");
							BufferedReader br = new BufferedReader(in, 1024);
							
							StringBuilder builder = new StringBuilder();
							String str;
							while(true){
								str = br.readLine();
								if(str == null)break;
								builder.append(str + "\n");
							}
							br.close();
							result = builder.toString();
							break;
						}else{
							break;
						}
					}catch(MalformedURLException me){
						me.printStackTrace();
						break;
					}catch(SocketTimeoutException se){
						se.printStackTrace();
						cnt++;
					}catch(IOException ie){
						ie.printStackTrace();
						break;
					}catch(Exception e){
						e.printStackTrace();
						break;
					}
				}while(cnt < 3);
			}catch(Exception e){
				return result;
			}
		}
		return result;
	}
}
