package suwon.web.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.orm.ibatis.SqlMapClientTemplate;

import suwon.web.dao.SpaceDao;
import suwon.web.vo.BuildSearchVo;
import suwon.web.vo.SpaceVo;

public class SpaceSearchService implements SpaceDao{
	private SqlMapClientTemplate sqlMapClientTemplate;
	private HashMap<String, Object> valueMap = new HashMap<String, Object>();

	public void setSqlMapClientTemplate(SqlMapClientTemplate sqlMapClientTemplate) {
		this.sqlMapClientTemplate = sqlMapClientTemplate;
	}
	@Override
	public List<SpaceVo> getSpaceList(String space_area) {
		System.out.println("getSpaceList : " + space_area);
		valueMap.put("space_area", space_area);
		return sqlMapClientTemplate.queryForList("sms.getSpaceList", space_area);
	}
	public List<HashMap<String, String>> getBuildGroup() {
		// TODO Auto-generated method stub
		List<HashMap<String, String>> return_value = sqlMapClientTemplate.queryForList("sms.getBuildGroup");
		System.out.println("getBuildGroup : " + return_value);
		return return_value;
	}
	
	/**
	 * 공간검색 > 반경검색 페이지 	
	 * @return
	 */	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<BuildSearchVo> searchBuildListForRadious(String msg, String searchlist, int startArticleNum, int endArticleNum) {
		System.out.println("searchlist : " + searchlist);
		 List<BuildSearchVo> reseult_vo = new ArrayList<BuildSearchVo>();
		 HashMap map = new HashMap();
		 
		 String arr[] = searchlist.split(",");
		 
		 int arr_length =arr.length/200;
		 
		 List  list = new ArrayList();
		 
		 for(int idx = 0 ; idx<=arr_length ; idx++){
			 StringBuffer sb = new StringBuffer();
			 int max_size = 200;
			 if(idx==arr_length){
				 max_size = arr.length%200;
			 }			 
			 for(int i=0;i<max_size;i++){
				 if(i==max_size-1){
					 sb.append("'"+arr[200*idx+i]+"'".toUpperCase());//수정전sb.append("'"+arr[200*idx+i]+"'");//대문자로 수정
					 
				 }else{
					 sb.append("'"+arr[200*idx+i]+"',".toUpperCase());//수정전sb.append("'"+arr[200*idx+i]+"'");//대문자로 수정
				 }
			 }
			 list.add(sb.toString().toUpperCase());//
		 }

		 map.put("searchList", list);
		 map.put("keyword", msg);
		 map.put("start",startArticleNum);
		 map.put("end", endArticleNum);
		 
		 List<BuildSearchVo> return_value = null;

		 return_value = sqlMapClientTemplate.queryForList("sms.getBuildListForRadiousSearch",map);

		return return_value;
	}
	public int searchBuildCntForRadious(String msg, String searchlist) {
		int total_cnt = 0;
		 HashMap map = new HashMap();
		 String arr[] = searchlist.split(",");
		 int arr_length =arr.length/200;
		 List  list = new ArrayList();
		 for(int idx = 0 ; idx<=arr_length ; idx++){
			 StringBuffer sb = new StringBuffer();
			 int max_size = 200;
			 if(idx==arr_length){
				 max_size = arr.length%200;
			 }			 
			 for(int i=0;i<max_size;i++){
				 if(i==max_size-1){
					 sb.append("'"+arr[200*idx+i]+"'".toUpperCase());//수정전sb.append("'"+arr[200*idx+i]+"'");//대문자로 수정
				 }else{
					 sb.append("'"+arr[200*idx+i]+"',".toUpperCase());//수정전sb.append("'"+arr[200*idx+i]+"'");
				 }
			 }
			 list.add(sb.toString().toUpperCase());//수정전list.add(sb.toString());
		 }
		 map.put("searchList", list);
		 map.put("keyword", msg);

		 total_cnt = (Integer)sqlMapClientTemplate.queryForObject("sms.getBuildCntForRadiousSearch",map);
		 		
		return total_cnt;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public List<BuildSearchVo> searchBuildListForRegion(String msg, String searchlist, int startArticleNum, int endArticleNum) {
		 List<BuildSearchVo> reseult_vo = new ArrayList<BuildSearchVo>();
		 
		 HashMap map = new HashMap();
		 
		 List  list = new ArrayList();
		 
		 String arr[] = searchlist.split(",");
		 
		 if(arr.length == 1 || arr == null){
			 if(arr[0].equals("")){
				 list.add((String)"''".toUpperCase());//대문자로 수정
			 }else{
				 list.add((String)arr[0].toUpperCase());//대문자로 수정
			 }
			 
		 }else{
			 int arr_length =arr.length/200;
			 
			 for(int idx = 0 ; idx<=arr_length ; idx++){
				 StringBuffer sb = new StringBuffer();
				 int max_size = 200;
				 if(idx==arr_length){
					 max_size = arr.length%200;
				 }			 
				 for(int i=0;i<max_size;i++){
					 if(i==max_size-1){
						 sb.append(arr[200*idx+i]);
						 
					 }else{
						 sb.append(arr[200*idx+i]+",");
					 }
				 }
				 list.add(sb.toString().toUpperCase());//list.add(sb.toString());//대문자로 바뀐것
				 
			 } 
		 }
		 
		 map.put("searchList", list);
		 map.put("keyword", msg);
		 map.put("start",startArticleNum);
		 map.put("end", endArticleNum);
		 
		 List<BuildSearchVo> return_value = null;

		 return_value = sqlMapClientTemplate.queryForList("sms.getBuildListForRadiousSearch",map);
		 
		return return_value;
	}
	public int searchBuildCntForRegion(String msg, String searchlist) {
		int total_cnt = 0;
		 HashMap map = new HashMap();
		 
		 String arr[] = searchlist.split(",");
		 
		 List  list = new ArrayList();
		 
		 
		 if(arr.length == 1 || arr == null){
			 if(arr[0].equals("")){
				 list.add("''");//list.add((String)"''".toUpperCase());//
			 }else{
				 list.add(arr[0]);//list.add((String)arr[0].toUpperCase());//
			 }
			 
		 }else{
			 int arr_length =arr.length/200;
			 
			 for(int idx = 0 ; idx<=arr_length ; idx++){
				 StringBuffer sb = new StringBuffer();
				 int max_size = 200;
				 if(idx==arr_length){
					 max_size = arr.length%200;
				 }			 
				 for(int i=0;i<max_size;i++){
					 if(i==max_size-1){
						 sb.append(arr[200*idx+i].toUpperCase());
						 
					 }else{
						 sb.append(arr[200*idx+i]+",".toUpperCase());
					 }
				 }
				 list.add(sb.toString().toUpperCase());//list.add(sb.toString().toUpperCase());//
			 } 
		 }
		 map.put("searchList", list);
		 map.put("keyword", msg);

		 total_cnt = (Integer)sqlMapClientTemplate.queryForObject("sms.getBuildCntForRadiousSearch",map);
		 		
		return total_cnt;
	}
}
