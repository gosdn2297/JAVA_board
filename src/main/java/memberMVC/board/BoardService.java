package memberMVC.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BoardService {
   BoardDAO boardDAO;
   
   public BoardService() {
      boardDAO = new BoardDAO(); //생성자에서 BoardDAO 객체를 생성
   }
   
// 오늘 추가한 코드
   public Map listArticles(Map<String, Integer> pagingMap) {
      Map articleMap = new HashMap();
      List<ArticleVO> articleList = boardDAO.selectAllArticles(pagingMap);
      int totArticles = boardDAO.selectToArticles();
      articleMap.put("articleList", articleList);
      articleMap.put("totArticles", totArticles);
//      articleMap.put("totArticles", 100);
      return articleMap;
   }
   
   public List<ArticleVO> listArticles() {
      List<ArticleVO> articleList = boardDAO.selectAllArticles();
      return articleList;
   }
   public int addArticle(ArticleVO articleVO) {
      return boardDAO.insertNewArticle(articleVO);
   }
   
   public ArticleVO viewArticle(int articleNo) {
      ArticleVO articleVO = null;
      articleVO = boardDAO.selectArticle(articleNo);
      return articleVO;
   }
   public void modArticle(ArticleVO articleVO) {
      boardDAO.updateArticle(articleVO);
   }
   public List<Integer> removeArticle(int articleNo) {
      List<Integer> articleNoList=boardDAO.selectRemovedArticles(articleNo);
      boardDAO.deleteArticle(articleNo);
      return articleNoList;
   }
   public int addReply(ArticleVO articleVO) {
	   return boardDAO.insertNewArticle(articleVO);
   }
}