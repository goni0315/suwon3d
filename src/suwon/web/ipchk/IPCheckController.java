package suwon.web.ipchk;

import java.net.InetAddress;
import java.net.UnknownHostException;

import net.sf.json.JSONArray;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
public class IPCheckController {
	@RequestMapping("/checkIP.do")
	@ResponseBody
	public JSONArray realEstateBulidNo(){
		JSONArray jsonArray = new JSONArray();
		String rIP = null;
		try {
			rIP = ipchk();
		} catch (UnknownHostException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		jsonArray.add(rIP);
		return jsonArray;
	}
	
	public String ipchk()throws UnknownHostException{
		InetAddress local = InetAddress.getLocalHost();

		String ip = local.getHostAddress();
		
		return ip;
	}
}
