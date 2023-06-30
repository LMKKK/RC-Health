import com.example.health.HealthBootApplication;
import com.example.health.mapper.CheckItemsDataMapper;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.Map;

@SpringBootTest(classes = {HealthBootApplication.class})
public class TestCheckItemDataMapper {

    @Autowired
    private CheckItemsDataMapper checkItemsDataMapper;

    @Test
    public void testGetGroupAndDocter(){
        List<Map<String, String>> lisst = checkItemsDataMapper.getGroupAndDocter(45, 16);
        System.out.println(lisst);

    }
}
