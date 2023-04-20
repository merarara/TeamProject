package com.project.springboot.cboard;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.springboot.utils.BoardPage;

@Controller
public class ListController {

	
    @Autowired
    C_BoardDAO dao;

    @Value("${posts_per_page}")
    private int pageSize;

    @Value("${pages_per_block}")
    private int blockPage;

    @RequestMapping(value = "/cboard/List.do", method = RequestMethod.GET)
    public String list(@RequestParam(name = "searchField", required = false) String searchField,
                       @RequestParam(name = "searchword", required = false) String searchword,
                       @RequestParam(name = "pageNum", required = false, defaultValue = "1") int pageNum,
                       Model model) {

        Map<String, Object> map = new HashMap<>();

        if (searchword != null) {
            map.put("searchField", searchField);
            map.put("searchword", searchword);
            // searchword가 null이 아닐 때만 해당 파라미터를 쿼리 실행에 사용합니다.
        }
        int totalCount = dao.selectCount(map);

        int start = (pageNum - 1) * pageSize + 1;
        int end = pageNum * pageSize;
        map.put("start", start);
        map.put("end", end);

        List<C_BoardDTO> boardLists = dao.selectListPage(map);

        String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, "/List");
        map.put("pagingImg", pagingImg);
        map.put("totalCount", totalCount);
        map.put("pageSize", pageSize);
        map.put("pageNum", pageNum);

        model.addAttribute("boardLists", boardLists);
        model.addAttribute("map", map);

        return "cboard/List";
    }
    
}
