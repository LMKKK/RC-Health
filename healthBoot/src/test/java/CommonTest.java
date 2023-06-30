import cn.hutool.core.util.ReUtil;
import org.junit.jupiter.api.Test;

public class CommonTest {

    @Test
    public void testReg(){

        String content = "28254321828";
        String pattern = "^1[3|4|5|7|8][0-9]{9}$";
        if(ReUtil.isMatch(pattern, content)){
            System.out.println("通过");
        }else{
            System.out.println("不通过");
        }

    }
}
