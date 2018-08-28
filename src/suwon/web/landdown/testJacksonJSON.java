/**
 * 
 */
package suwon.web.landdown;


import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;
 
import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

public class testJacksonJSON {
	 /**
     * @param args
     */
    public static void main(String[] args) {
 
         
        try {
 
            ObjectMapper mapper = new ObjectMapper(); // 재사용 가능하고 전체코드에서 공유함.
 
 
            //String user_json = "{\"RESULT_CODE\":\"00\",\"DATA_LIST\":[{\"sws\":\"32.6568\",\"sm_basin_cd\":\"100101\",\"fc_tm\":\"201601122100\"},{\"sws\":\"32.655\",\"sm_basin_cd\":\"100101\",\"fc_tm\":\"201601122200\"},{\"sws\":\"32.6533\",\"sm_basin_cd\":\"100101\",\"fc_tm\":\"201601122300\"},{\"sws\":\"32.6515\",\"sm_basin_cd\":\"100101\",\"fc_tm\":\"201601130000\"}";;
           String user_json = "{\"RESULT_CODE\" : [{ \"first\" : \"Joe\", \"last\" : \"Sixpack\" }], "
                    + " \"gender\" : \"MALE\", "
                    + " \"verified\" : false, "
                    + " \"userImage\" : \"Rm9vYmFyIQ==\" " + "     }";
           user_json = user_json.toLowerCase();
           System.out.println(user_json);
            User user = mapper.readValue(user_json, User.class);
             
            System.out.println("First name : " + user.getResult_Code().getFirst());
            System.out.println("Last name : " + user.getResult_Code().getLast());
            //System.out.println("Gender : " + user.getGender());
            System.out.println("Verified : " + user.isVerified());
            
            /*
            user.getName().setFirst("ChangeJoe");
            user.getName().setLast("ChangeSixpack");
             
            String jsonStr = mapper.writeValueAsString(user);
            System.out.println("Simple Binding : "+jsonStr);
             
            //직접 raw 데이터를 입력해서 JSON형태로 출력하는 방법.
            Map<string,object> userData = new HashMap<string,object>();
            Map<string,string> nameStruct = new HashMap<string,string>();
            nameStruct.put("first", "RawJoe");
            nameStruct.put("last", "Sixpack");
            userData.put("name", nameStruct);
            userData.put("gender", "MALE");
            userData.put("verified", Boolean.FALSE);
            userData.put("userImage", "Rm9vYmFyIQ==");
             
            jsonStr = mapper.writeValueAsString(userData);
            System.out.println("Raw Data : "+jsonStr);*/
             /*
            //Tree 모델 예제
            ObjectMapper m = new ObjectMapper();
            // mapper.readTree(source), mapper.readValue(source, JsonNode.class); 둘중 하나 사용가능.
            JsonNode rootNode = m.readTree(user_json);
 
            JsonNode nameNode = rootNode.path("name");
            String lastName = nameNode.path("last").textValue();
            ((ObjectNode)nameNode).put("last", "inputLast");
             
            jsonStr = m.writeValueAsString(rootNode);
            System.out.println("Tree Model : "+jsonStr);
             
             
            //Streaming API 예제
            JsonFactory f = new JsonFactory();
             
            OutputStream outStr = System.out;
 
            JsonGenerator g = f.createJsonGenerator(outStr);
 
            g.writeStartObject();
            g.writeObjectFieldStart("name");
            g.writeStringField("first", "StreamAPIFirst");
            g.writeStringField("last", "Sixpack");
            g.writeEndObject(); // 'name' 필드용.
            g.writeStringField("gender", "MALE");
            g.writeBooleanField("verified", false);
            g.writeFieldName("userImage");
            g.writeEndObject();
            g.close(); // 사용한 다음 close해줘서 output에 있는 내용들을 flush해야함.
             */
             
        } catch (JsonParseException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (JsonMappingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
        e.printStackTrace();
        }
         
         
    }
 
}

class User {
    public enum Gender { male, female };
 
    public static class ResultCode {
      private String first, last;
 
      public String getFirst() { return first; }
      public String getLast() { return last; }
 
      public void setFirst(String s) { first = s; }
      public void setLast(String s) { last = s; }
    }
 
    private Gender gender;
    private ResultCode result_code;
    private boolean isVerified;
    private byte[] userimage; 
    
 
    public ResultCode getResult_Code() { 
    	return result_code; 
    }
    public boolean isVerified() { 
    	return isVerified; 
    }
    public Gender getGender() { 
    	return gender; 
    }
    public byte[] getUserimage() { 
    	return userimage; 
    }
 
    public void setResult_code(ResultCode n) {
    	result_code = n; 
    }
    public void setVerified(boolean b) {
    	isVerified = b; 
    }
    public void setGender(Gender g) {
    	gender = g; 
    }
    public void setUserImage(byte[] b) {
    	userimage = b;
    }
	public ResultCode getResult_code() {
		return result_code;
	}

}
