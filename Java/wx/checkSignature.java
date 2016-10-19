/**
  * 微信公众平台 成为开发者验证入口
  *
  * @param request
  *            the request send by the client to the server
  * @param response
  *            the response send by the server to the client
  * @throws ServletException
  *             if an error occurred
  * @throws IOException
  *             if an error occurred
  */
 public void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {

     // 微信加密签名
     String signature = request.getParameter("signature");
     // 随机字符串
     String echostr = request.getParameter("echostr");
     // 时间戳
     String timestamp = request.getParameter("timestamp");
     // 随机数
     String nonce = request.getParameter("nonce");

     String[] str = { TOKEN, timestamp, nonce };
     Arrays.sort(str); // 字典序排序
     String bigStr = str[0] + str[1] + str[2];
     // SHA1加密
     String digest = new SHA1().getDigestOfString(bigStr.getBytes()).toLowerCase();

     // 确认请求来至微信
     if (digest.equals(signature)) {
         response.getWriter().print(echostr);
     }
 }
