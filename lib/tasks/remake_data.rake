namespace :db do
  desc "remake database data"
  task remake_data: :environment do
    if Rails.env.development? || Rails.env.staging?
      ["db:drop", "db:create", "db:migrate", "db:seed"].each do |action|
        Rake::Task[action].invoke
      end

      puts "Creating users"

      10.times do
        Fabricate :user
      end

      puts "Creating admin"

      User.create! ([
        {name: "Do Gia Dat", user_name: "do.gia.dat", email: "do.gia.dat@framgia.com",
          status: 0, role: 0, password: "12345678", password_confirmation: "12345678",
          avatar: File.open(File.join(Rails.root, "app/assets/images/users/do_gia_dat.jpg"))
        },

        {name: "Tran Xuan Thang", user_name: "tran.xuan.thang",
          email: "tran.xuan.thang@framgia.com", status: 0, role: 0,
          password: "12345678", password_confirmation: "12345678",
          avatar: File.open(File.join(Rails.root, "app/assets/images/users/tran_xuan_thang.jpg"))
        },

        {name: "Nguyen Huu Tien", user_name: "nguyen.huu.tien",
        email: "nguyen.huu.tien@framgia.com", status: 0, role: 0,
        password: "12345678", password_confirmation: "12345678",
        avatar: File.open(File.join(Rails.root, "app/assets/images/users/nguyen_huu_tien.jpg"))
        }
      ])

      puts "Creating Categories"

      ["radio online", "blog của tôi", "blog cuộc sống", "thơ blog"].each do |name|
        Fabricate :category, name: name
      end

      ["blog radio", "radio tâm sự", "radio tâm hồn", "radio giải trí", "radio tin tức",
        "radio đọc truyện", "radio theo giọng đọc"].each do |name|
        Fabricate :category, name: name, parent_id: 1
      end

      ["yêu 24/7", "cafe.blog", "hôm nay nghe gì", "truyện online",
        "blog family"].each do |name|
        Fabricate :category, name: name, parent_id: 2
      end

      ["sống đẹp", "chiêm tinh", "thư giãn"].each do |name|
        Fabricate :category, name: name, parent_id: 3
      end

      (1..20).each do |id|
        Advertisment.create(description: "Description #{id}",
          url: "url #{id}",
          image: "xe_dap")
      end

      puts "Creating accepted posts - normal"
      Post.create(
        post_type: :normal,
        title: "Công cha nghĩa mẹ",
        description: "Công cha nghĩa mẹ",
        content: '<p><font face="Arial">C&ocirc;ng cha nặng lắm ai ơi</font><br />
          <font face="Arial">Nghĩa mẹ bằng trời, ch&iacute;n th&aacute;ng cưu mang.</font><br />
          <font face="Arial">Con ch&agrave;o đời, th&aacute;ng Gi&ecirc;ng sang</font><br />
          <font face="Arial">Trải qua ch&iacute;n th&aacute;ng, mẹ c&agrave;ng n&acirc;ng niu.</font><br />
          <br />
          <font face="Arial">L&uacute;c sinh, con nhỏ x&iacute;u xiu</font><br />
          <font face="Arial">Từng bước chập chững, mẹ d&igrave;u, cha n&acirc;ng.</font><br />
          <font face="Arial">Gọi cha, gọi mẹ, dạ, v&acirc;ng.</font><br />
          <font face="Arial">Từng c&acirc;u, từng chữ, từng vần y&ecirc;u thương.<br />
          <br />
          <img alt="Tình cha nghĩa mẹ" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_10/Ngay_31/Images/cong-cha-nghia-me.jpg" /></font><br />
          <br />
          <font face="Arial">Năm tuổi con được đến trường</font><br />
          <font face="Arial">C&oacute; mẹ đưa đ&oacute;n, y&ecirc;u thương c&agrave;ng nhiều.</font><br />
          <font face="Arial">Qu&agrave; b&aacute;nh mẹ mua mỗi chiều</font><br />
          <font face="Arial">Sau khi tan chợ, li&ecirc;u xi&ecirc;u mẹ về.</font><br />
          <br />
          <font face="Arial">Nu&ocirc;i con biết mấy &ecirc; chề</font><br />
          <font face="Arial">Thức khuya, dậy sớm, mải m&ecirc; ruộng vườn.</font><br />
          <font face="Arial">Việc nh&agrave;, việc vườn tinh tươm</font><br />
          <font face="Arial">Con l&agrave; hạt giống mẹ ươm v&agrave;o đời.</font><br />
          <br />
          <font face="Arial">T&igrave;nh cha nghĩa mẹ đ&ocirc;i lời</font><br />
          <font face="Arial">L&agrave;m sao n&oacute;i hết, cuộc đời hiến d&acirc;ng.</font><br />
          <font face="Arial">Lặng l&ograve;ng những nỗi b&acirc;ng khu&acirc;ng</font><br />
          <font face="Arial">Mong sao cha mẹ gian tru&acirc;n chẳng c&ograve;n.</font><br />
          <br />
          <font face="Arial">Bổn phận, tr&aacute;ch nhiệm l&agrave;m con</font><br />
          <font face="Arial">Mong sao chữ hiếu được tr&ograve;n đầy hơn.</font></p>
          ',
        status: :accepted,
        user_id: 11,
        category_id: 2,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/1.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      Post.create(
        post_type: :normal,
        title: "Những bài học bạn ước mình biết sớm hơn",
        description: "Buông tay một người thực sự rất khó, bạn sẽ cần rất nhiều thời gian.
         Nhưng chỉ là rất lâu chứ không có nghĩa là không thể quên...",
        content: '<p><font face="Arial">1. Bạn để &yacute; thứ g&igrave;, thứ ấy sẽ d&agrave;y v&ograve; bạn.</font><br />
          <br />
          <font face="Arial">2. Bạn l&agrave;m mất một c&aacute;i điện thoại iPhone 6s, mẹ bạn biết v&agrave; mua cho bạn một chiếc iPhone 7, bạn vẫn sẽ cảm thấy vui. Nếu người y&ecirc;u bạn chia tay với bạn, nhưng người bạn ngưỡng mộ từ l&acirc;u tỏ t&igrave;nh với bạn, bạn vẫn kh&ocirc;ng kiềm chế được trở n&ecirc;n vui hơn.</font><br />
          <br />
          <font face="Arial">Con người ai cũng vậy, kh&ocirc;ng phải bạn sợ mất đi, m&agrave; chỉ sợ mất đi rồi sẽ kh&ocirc;ng c&oacute; thứ tốt hơn để thay thế.</font><br />
          <br />
          <font face="Arial">3. Người m&atilde;i m&atilde;i đối tốt với bạn chỉ c&oacute; bố mẹ của bạn th&ocirc;i.</font><br />
          <br />
          <font face="Arial">4. Thoải m&aacute;i một ch&uacute;t m&agrave; sống cuộc sống của bạn đi, bạn chẳng c&oacute; nhiều kh&aacute;n giả tới vậy đ&acirc;u.</font><br />
          <br />
          <font face="Arial">5. Đừng l&uacute;c n&agrave;o cũng cho rằng x&acirc;y dựng quan hệ l&agrave; quan trọng nhất, chẳng c&oacute; g&igrave; l&agrave; quan trọng hơn việc khiến bản th&acirc;n trở n&ecirc;n mạnh mẽ v&agrave; ưu t&uacute; hơn cả.</font><br />
          <br />
          <font face="Arial">6. Bạn c&oacute; thể y&ecirc;u năm, ba kẻ kh&ocirc;ng ra g&igrave;, nhưng bạn kh&ocirc;ng thể y&ecirc;u một kẻ kh&ocirc;ng ra g&igrave; năm, ba lần.</font><br />
          <br />
          &nbsp;</p>

          <p><font face="Arial"><img alt="Những bài học bạn ước mình biết sớm hơn" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_10/Ngay_24/Images/nhung-bai-hoc-ban-uoc-minh-biet-som-hon1.jpg" /></font><br />
          &nbsp;</p>

          <p><font face="Arial">7. Đừng ngại phải từ chối người kh&aacute;c, bởi những người kh&ocirc;ng ngại l&agrave;m kh&oacute; bạn cũng chẳng phải người tốt g&igrave;.</font><br />
          <br />
          <font face="Arial">8. Ngay l&uacute;c bạn n&oacute;i xấu một ai đ&oacute; sau lưng, bạn đ&atilde; thua rồi. Bởi bạn biến người kh&aacute;c th&agrave;nh chủ đề b&agrave;n luận của bạn trong khi người kh&aacute;c lại cảm thấy bạn chẳng đ&aacute;ng nhắc tới.</font><br />
          <br />
          <font face="Arial">9. Kh&ocirc;ng y&ecirc;u cũng kh&ocirc;ng chết được.</font><br />
          <br />
          <font face="Arial">10. Kh&ocirc;ng cần phải quan t&acirc;m đến &aacute;nh mắt người kh&aacute;c mọi l&uacute;c mọi nơi, chỉ c&oacute; như vậy bạn mới c&oacute; thể vui vẻ, thoải m&aacute;i m&agrave; sống.</font><br />
          <br />
          <font face="Arial">11. Xấu cũng kh&ocirc;ng sao cả, bởi người kh&aacute;c m&agrave; tẩy trang đi cũng chẳng đẹp ở điểm n&agrave;o.</font><br />
          <br />
          <font face="Arial">12. Một người kh&ocirc;ng chủ động li&ecirc;n lạc với bạn ch&iacute;nh l&agrave; kh&ocirc;ng nhớ bạn, cũng c&oacute; thể l&agrave; chẳng hề th&iacute;ch bạn. Nhắn tin với bạn m&agrave; chỉ to&agrave;n hai, ba c&acirc;u hoặc d&ugrave;ng emoticon ch&iacute;nh l&agrave; kh&ocirc;ng c&oacute; hứng th&uacute; với bạn. N&oacute;i rất nhiều nhưng kh&ocirc;ng c&oacute; h&agrave;nh động thực tế ch&iacute;nh l&agrave; chỉ coi bạn như h&agrave;ng dự bị. Bạn kh&ocirc;ng cần phải kiếm cớ thay người kh&aacute;c, cũng kh&ocirc;ng cần phải l&atilde;ng ph&iacute; t&igrave;nh cảm của m&igrave;nh, hay nhanh ch&oacute;ng đối diện với sự thật hoặc bu&ocirc;ng tay th&ocirc;i.</font><br />
          <br />
          <font face="Arial">13. Một người nếu muốn đối tốt với bạn th&igrave; rất dễ d&agrave;ng, một người nếu muốn th&iacute;ch bạn cũng rất dễ d&agrave;ng, quan trọng l&agrave; sự ki&ecirc;n tr&igrave;. Một người khi ở b&ecirc;n bạn, đối tốt với bạn ch&iacute;nh l&agrave; th&iacute;ch bạn. Nhưng kể cả khi hai người kh&ocirc;ng c&ograve;n b&ecirc;n nhau nữa, người ấy vẫn đối tốt với bạn, đ&oacute; mới l&agrave; thực sự y&ecirc;u bạn.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt="Những bài học bạn ước mình biết sớm hơn" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_10/Ngay_24/Images/nhung-bai-hoc-ban-uoc-minh-biet-som-hon2.jpg" /></font></p>

          <p><br />
          <font face="Arial">14. Đừng động t&iacute; l&agrave; lại b&ocirc; b&ocirc; tất cả l&ecirc;n Facebook.</font><br />
          <br />
          <font face="Arial">15. Khi bạn cảm thấy mệt mỏi, h&atilde;y nhớ bạn đang leo được đến giữa sườn n&uacute;i rồi.</font><br />
          <br />
          <font face="Arial">16. Đừng kh&oacute;c trước mặt người kh&aacute;c. Đừng quyết định việc g&igrave; quan trọng v&agrave;o đ&ecirc;m khuya. Quan trọng hơn l&agrave; đừng tin lời mẹ n&oacute;i rằng bạn rất gầy.</font><br />
          <br />
          <font face="Arial">17. Đừng giằng co nữa, người ấy kh&ocirc;ng y&ecirc;u bạn đ&acirc;u. Đừng nhớ m&atilde;i qu&aacute; khứ như thế, sự si t&igrave;nh của bạn chỉ l&agrave; g&aacute;nh nặng với một người đ&atilde; quyết t&acirc;m ra đi. C&aacute;c c&ocirc; g&aacute;i, c&ugrave;ng cố gắng nh&eacute;!</font><br />
          <br />
          <font face="Arial">18. Bu&ocirc;ng tay một người thực sự rất kh&oacute;, bạn sẽ cần rất nhiều thời gian. Nhưng chỉ l&agrave; rất l&acirc;u chứ kh&ocirc;ng c&oacute; nghĩa l&agrave; kh&ocirc;ng thể qu&ecirc;n...</font><br />
          <br />
          <font face="Arial">19. Ngoại t&igrave;nh chỉ c&oacute; 0 lần v&agrave; v&ocirc; số lần.</font><br />
          <br />
          <font face="Arial">20. Tất cả những đau khổ bạn từng trải qua chỉ đang gi&uacute;p ch&iacute;nh bản th&acirc;n bạn trưởng th&agrave;nh v&agrave; trở th&agrave;nh một con người tốt đẹp hơn.</font><br />
          <br />
          <font face="Arial"><strong>Blog Radio Tổng hợp.</strong></font></p>
          ',
        status: :accepted,
        user_id: 11,
        category_id: 4,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/2.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      Post.create(
        post_type: :normal,
        title: "Tại sao phải mang theo một tảng đá bên mình?",
        description: "Tảng đá to và nặng thật đấy, nhưng ta đâu cần phải mang vác nó lên. Mà nếu như ta không mang vác chúng lên thì mình cũng đâu có gì cần phải buông bỏ, phải không bạn?",
        content: '<p><font face="Arial"><em>C&oacute; lần Ng&agrave;i Ajahn Chah đi dạo với c&aacute;c đệ tử của m&igrave;nh. Ng&agrave;i chỉ v&agrave;o một tảng đ&aacute; thật to b&ecirc;n đường v&agrave; hỏi, &ldquo;C&aacute;c thầy thấy tảng đ&aacute; đ&oacute; c&oacute; nặng kh&ocirc;ng?&rdquo; C&aacute;c đệ tử nh&igrave;n tảng đ&aacute; to lớn ấy v&agrave; trả lời, &ldquo;Dạ thưa, n&oacute; rất nặng.&rdquo; Ajahn Chah mỉm cười n&oacute;i, &ldquo;N&oacute; đ&acirc;u c&oacute; nặng, nếu như ta đừng cố gắng mang v&aacute;c n&oacute; l&ecirc;n!&rdquo;</em><br />
          <br />
          Mỗi khi gặp một vấn đề kh&oacute; khăn hay đối diện với những phiền n&atilde;o trong cuộc sống, bạn h&atilde;y thử tự hỏi m&igrave;nh c&acirc;u hỏi ấy của ng&agrave;i Ajahn Chan, &ldquo;N&oacute; c&oacute; nặng kh&ocirc;ng?&rdquo; V&agrave; nếu như ta kh&ocirc;ng muốn dời đổi hay mang v&aacute;c n&oacute; l&ecirc;n, th&igrave; đ&acirc;u c&oacute; l&agrave; nặng phải kh&ocirc;ng bạn?<br />
          <br />
          C&aacute;c thiền sư thường nhắc nhở ch&uacute;ng ta rằng, ngay giữa những kh&oacute; khăn của cuộc đời m&agrave; ta thấy được nguy&ecirc;n nh&acirc;n của phiền n&atilde;o, v&agrave; sự chấm dứt của n&oacute; cũng c&oacute; mặt ở ngay tại nơi ấy, chứ kh&ocirc;ng cần phải t&igrave;m kiếm ở một nơi n&agrave;o kh&aacute;c.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt="Tại sao phải mang theo một tảng đá bên mình?" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_11/Ngay_9/Images/mang-hon-da-ben-minh.jpg" /></font></p>

          <p><br />
          <font face="Arial">Đ&oacute; c&oacute; thể l&agrave; những gi&acirc;y ph&uacute;t lo &acirc;u, phiền muộn trong t&acirc;m, hay những cảm gi&aacute;c kh&oacute; chịu, đau nhức ở th&acirc;n. Nếu như ta biết c&oacute; mặt trọn vẹn với những g&igrave; xảy ra, ta sẽ kh&ocirc;ng mang v&aacute;c th&ecirc;m cho m&igrave;nh những nỗi khổ kh&ocirc;ng cần thiết, của sự mong cầu, muốn dời đổi, muốn l&agrave;m cho n&oacute; được kh&aacute;c đi.<br />
          <br />
          Nhưng điều ấy kh&ocirc;ng c&oacute; nghĩa l&agrave; ta c&oacute; một th&aacute;i độ dửng dưng, hoặc tr&aacute;nh n&eacute; những kh&oacute; khăn trong cuộc sống, m&agrave; l&agrave; biết quan s&aacute;t những g&igrave; xảy ra trong ch&aacute;nh niệm v&agrave; tỉnh gi&aacute;c. N&oacute; gi&uacute;p ta thấy được rằng c&oacute; những sự việc trong đời ta kh&ocirc;ng tr&aacute;nh được, ch&uacute;ng đến v&agrave; đi theo luật nh&acirc;n quả tự nhi&ecirc;n.<br />
          <br />
          Như một ng&agrave;y m&acirc;y m&ugrave; k&eacute;o đến che lấp phủ k&iacute;n lối đi, hay l&agrave; sương tan ch&acirc;n trời rộng mở. Nhưng v&igrave; sự mong cầu v&agrave; th&aacute;i độ phản ứng vội v&agrave;ng của một c&aacute;i T&ocirc;i nhỏ b&eacute;, đ&atilde; khiến ta kh&ocirc;ng thể sống trọn vẹn được với thực tại ấy. N&oacute; xui ta cố gắng v&aacute;c l&ecirc;n th&ecirc;m cho m&igrave;nh những g&aacute;nh nặng kh&ocirc;ng cần thiết.<br />
          <br />
          Thật ra sự trọn vẹn kh&ocirc;ng c&oacute; một khu&ocirc;n mẫu nhất định n&agrave;o hết. Sống trọn vẹn kh&ocirc;ng c&oacute; nghĩa l&agrave; ta phải cố sống đ&uacute;ng theo một phương c&aacute;ch n&agrave;o đ&oacute;, m&agrave; chỉ c&oacute; nghĩa l&agrave; ta trở lại với những g&igrave; đang c&oacute; mặt nơi th&acirc;n t&acirc;m m&igrave;nh, v&agrave; để y&ecirc;n cho n&oacute; được như n&oacute; l&agrave;. C&oacute; khi đ&oacute; l&agrave; sự khinh an, m&agrave; cũng c&oacute; khi đ&oacute; l&agrave; những bất an.<br />
          <br />
          Để y&ecirc;n kh&ocirc;ng c&oacute; nghĩa l&agrave; chấp nhận hay bu&ocirc;ng xu&ocirc;i, nhưng n&oacute; gi&uacute;p ta c&oacute; lại được một sự tĩnh lặng để thấy r&otilde; những g&igrave; đang thật sự c&oacute; mặt. V&agrave; rồi nếu cần, ta cứ l&agrave;m những g&igrave; m&igrave;nh cần l&agrave;m v&agrave; c&oacute; thể l&agrave;m được. Bạn biết kh&ocirc;ng, cuộc đời c&oacute; thể chỉ b&agrave;y cho ta nhiều phương c&aacute;ch để dời đổi tảng đ&aacute;, nhưng nhiều khi sự c&oacute; mặt của tảng đ&aacute; ấy l&agrave; để ta c&oacute; dịp nh&igrave;n lại v&agrave; thấy r&otilde; m&igrave;nh hơn.<br />
          <br />
          Tảng đ&aacute; to v&agrave; nặng thật đấy, nhưng ta đ&acirc;u cần phải mang v&aacute;c n&oacute; l&ecirc;n. M&agrave; nếu như ta kh&ocirc;ng mang v&aacute;c ch&uacute;ng l&ecirc;n th&igrave; m&igrave;nh cũng đ&acirc;u c&oacute; g&igrave; cần phải bu&ocirc;ng bỏ, phải kh&ocirc;ng bạn?<br />
          <br />
          <strong>T&aacute;c giả: Nguyễn Duy Nhi&ecirc;n &ndash; Theo Vườn hoa Phật gi&aacute;o</strong><br />
          <br />
          <strong>Giọng đọc: Hằng Nga<br />
          <br />
          Bi&ecirc;n tập v&agrave; thực hiện chương tr&igrave;nh: Hằng Nga</strong><br />
          <br />
          <em>(*) Ti&ecirc;u đề đ&atilde; được thay đổi. B&agrave;i viết gốc xem&nbsp;<a href="http://vuonhoaphatgiao.com/goc-suy-ngam/tang-da-co-nang-khong/">tại đ&acirc;y.</a></em></font></p>
          ',
        status: :accepted,
        user_id: 11,
        category_id: 6,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/3.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      Post.create(
        post_type: :normal,
        title: "",
        description: Faker::Hipster.sentence,
        content: '',
        status: :accepted,
        user_id: 11,
        category_id: 3,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/1.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      Post.create(
        post_type: :normal,
        title: "Có những ngày con chỉ muốn về nhà",
        description: "Ở mảnh đất thị thành xa xôi, ở cái chốn đất khách quê người, ở cái nơi mà người ta chỉ gửi trao nhau những hẹp hòi hắt hủi… Đã có những lúc dường như con bất lực, con không biết phải làm sao để được lòng thiên hạ, để được người đời đối xử tử tế… Đã có lúc trong cái se se của mùa về chớm lạnh, trong cái ráo riết hối hả của một sớm thu qua, con đi trên phố mà thấy mặn mà những nhớ thương, chân bước chẳng đặng mà dạ muốn ở cũng chẳng đừng, lòng nôn nao một miền thương nhớ đã cũ mà hoài hướng vẫn còn vương… Đã có những lúc con muốn trở về với mẹ, với ba, với mái ấm lúc nào cũng ắp đầy yêu thương, dẫu chẳng nói ra nhưng vẫn âm thầm lặng lẽ, giấc ngủ bình yên khi có mẹ chở che!",
        content: '<p><br />
          <font face="Arial">Những ng&agrave;y cuối thu,v&agrave;o những h&ocirc;m m&agrave; Đ&agrave; Nẵng lạnh t&ecirc; bởi những cơn mưa cuối m&ugrave;a, con sẽ lại bắt gặp đ&acirc;u đ&oacute; tr&ecirc;n đường, những người gi&agrave;, m&igrave;nh co ro trong chiếc &aacute;o mưa mỏng manh năm, mười ng&agrave;n. Đầu đội chiếc n&oacute;n r&aacute;ch, hứng trọn vẹn cơn mưa. Đ&ocirc;i vai gầy xanh run run khe khẽ, cố chống chọi với những đợt gi&oacute; t&agrave;n nhẫn đến buốt cả tim... Chợt chạnh l&ograve;ng nhớ về nơi ch&ocirc;n rau cắt rốn, ở nơi đ&oacute;, c&oacute; những người th&acirc;n thương vẫn từng ng&agrave;y l&agrave;m lụng vất vả, &quot;b&aacute;n mặt cho đất, b&aacute;n lưng cho trời&rdquo; chỉ cốt c&oacute;p nhặt từng đồng tiền lẻ chờ đến th&aacute;ng gửi v&agrave;o cho con! Chỉ để cố giấu giếm đi bao nỗi nhọc nhằn đeo b&aacute;m tr&ecirc;n vai cho đứa con thơ ng&acirc;y nụ cười!</font><br />
          <br />
          <font face="Arial">Những ng&agrave;y cuối thu, ngồi ngắm những chiếc l&aacute; v&agrave;ng c&ograve;n s&oacute;t lại tr&ecirc;n c&acirc;y, thấy vương trong sắc v&agrave;ng buồn đến lạ l&ugrave;ng kia c&oacute; ch&uacute;t m&agrave;u tiếc nuối pha trộn ch&uacute;t n&iacute;u k&eacute;o&hellip; V&agrave; dường như nhận ra quy luật mu&ocirc;n đời của tạo h&oacute;a, những chiếc l&aacute; cứ thế nhẹ nh&agrave;ng dứt bỏ c&agrave;nh, thả m&igrave;nh rơi theo gi&oacute;, nhưng h&igrave;nh như c&oacute; ch&uacute;t ngại ngần b&acirc;ng quơ, n&oacute; kh&ocirc;ng rơi xuống ngay m&agrave; chao qua chao lại trong kh&ocirc;ng trung như đang vẫy tay ch&agrave;o tạm biệt m&ugrave;a thu, như để lần cuối được ng&acirc;y ngất sống trọn vẹn cho thu&hellip;</font><br />
          <br />
          <font face="Arial">Những ng&agrave;y cuối thu, nằm nghĩ về những người th&acirc;n y&ecirc;u m&agrave; se thắt tr&aacute;i tim!</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt=" Có những ngày con chỉ muốn về nhà " src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_10/Ngay_28/Images/co-nhung-ngay-con-chi-muon-ve-nha21.jpg" /></font></p>

          <p><br />
          <font face="Arial">Ở mảnh đất thị th&agrave;nh xa x&ocirc;i, ở c&aacute;i chốn đất kh&aacute;ch qu&ecirc; người, ở c&aacute;i nơi m&agrave; người ta chỉ gửi trao nhau những hẹp h&ograve;i hắt hủi&hellip; Đ&atilde; c&oacute; những l&uacute;c dường như con bất lực, con kh&ocirc;ng biết phải l&agrave;m sao để được l&ograve;ng thi&ecirc;n hạ, để được người đời đối xử tử tế&hellip; Đ&atilde; c&oacute; l&uacute;c trong c&aacute;i se se của m&ugrave;a về chớm lạnh, trong c&aacute;i r&aacute;o riết hối hả của một sớm thu qua, con đi tr&ecirc;n phố m&agrave; thấy mặn m&agrave; những nhớ thương, ch&acirc;n bước chẳng đặng m&agrave; dạ muốn ở cũng chẳng đừng, l&ograve;ng n&ocirc;n nao một miền thương nhớ đ&atilde; cũ m&agrave; ho&agrave;i hướng vẫn c&ograve;n vương&hellip; Đ&atilde; c&oacute; những l&uacute;c con muốn trở về với mẹ, với ba, với m&aacute;i ấm l&uacute;c n&agrave;o cũng ắp đầy y&ecirc;u thương, dẫu chẳng n&oacute;i ra nhưng vẫn &acirc;m thầm lặng lẽ, giấc ngủ b&igrave;nh y&ecirc;n khi c&oacute; mẹ chở che!</font><br />
          <br />
          <font face="Arial">Con tưởng như rằng Đ&agrave; Nẵng cũng điệu đ&agrave; lắm, nhưng h&oacute;a ra n&oacute; cũng qu&ecirc; m&ugrave;a như miền đất cằn cỗi qu&ecirc; m&igrave;nh, một cơn gi&oacute; thốc qua rồi l&aacute; kh&ocirc; cứ bay v&egrave;o trong gi&oacute; sớm, con h&iacute;t c&aacute;i nồng đượm mặn m&agrave; của những kỷ niệm ng&agrave;y ấu thơ, điều đ&oacute; c&agrave;ng l&agrave;m con nhớ nh&agrave; da diết! In về trong t&acirc;m tr&iacute; d&aacute;ng mẹ hao gầy một sớm tất tưởi việc đồng &aacute;ng v&igrave; con, lảng vảng tiếng g&agrave; c&ograve;n chưa dứt. Ba đi l&agrave;m thu&ecirc; l&agrave;m mướn trang trải nắng mưa cho đời con ngọt lịm ph&ugrave; sa, c&aacute;i vị nồng nồng nu&ocirc;i l&uacute;a nu&ocirc;i người, nu&ocirc;i những tấm l&ograve;ng son, nu&ocirc;i những ho&agrave;i b&atilde;o lớn, nu&ocirc;i một mảnh t&igrave;nh cỏn con vẫn đang c&ograve;n bỏ ngỏ&hellip;</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt=" Có những ngày con chỉ muốn về nhà " src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_10/Ngay_28/Images/co-nhung-ngay-con-chi-muon-ve-nha2.jpg" /></font></p>

          <p><br />
          <font face="Arial">C&oacute; những l&uacute;c vụng dại con đ&atilde; cho rằng bạn b&egrave; mới l&agrave; điều cần thiết v&agrave; quan trọng nhất. V&igrave; bạn b&egrave; lắng nghe con n&oacute;i, chơi đ&ugrave;a c&ugrave;ng con, vấp ng&atilde; c&ugrave;ng con, thấu hiểu v&agrave; đồng cảm với con hơn. Nhưng chỉ một tho&aacute;ng thời gian tr&ocirc;i qua, khi ngậm ng&ugrave;i cay đắng đủ điều, con mới chợt giật m&igrave;nh nhận ra gia đ&igrave;nh mới l&agrave; nơi quan trọng nhất. L&agrave; nơi vỗ về con khi con gục ng&atilde;, sẵn l&ograve;ng ủng hộ bước con đi, cũng kh&ocirc;ng bao giờ quay lưng khi con bỗng dưng k&eacute;m cỏi.</font><br />
          <br />
          <font face="Arial">Giờ đ&acirc;y, khi đang ngồi trong g&oacute;c tối ph&ograve;ng trọ, con mới thấm th&iacute;a nỗi nhớ mẹ, nhớ ba, thấm th&iacute;a bao nỗi nhọc nhằn, vất vả m&agrave; mẹ ba đ&atilde; tự nguyện chịu đựng để đổi lấy hạnh ph&uacute;c cho con&hellip;</font><br />
          <br />
          <font face="Arial">Giữa chốn đ&ocirc;ng người, con hiểu ra qu&ecirc; nh&agrave; dẫu một nắng với mấy sương th&igrave; l&ograve;ng cũng dặn l&ograve;ng vẹn nghĩa t&igrave;nh xưa, vẹn một lần hướng tr&ocirc;ng, vẹn một hơi thở c&ograve;n nghe m&ugrave;i đất ngọt, vẹn một lần quay đầu trở về đ&aacute;p đền hương vị ph&ugrave; sa nồng n&agrave;n nu&ocirc;i t&igrave;nh con kh&ocirc;n lớn&hellip;</font><br />
          <br />
          <font face="Arial"><strong>Ba mẹ c&oacute; biết kh&ocirc;ng, c&oacute; những ng&agrave;y con chỉ muốn về qu&ecirc;!</strong></font><br />
          <br />
          <font face="Arial"><strong>&copy; Mỹ Thiệp &ndash; blogradio.vn</strong></font></p>
          ',
        status: :accepted,
        user_id: 11,
        category_id: 2,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/4.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      Post.create(
        post_type: :normal,
        title: "Hà Nội tháng 11 tím rực trong tim",
        description: "Hà Nội tháng 11, những ngày trở gió là cô đơn tìm về cứ bon chen len vào mọi ngóc ngách trong tim; là có đôi bàn tay đưa ra nhưng chẳng muốn nắm bởi cô đơn từ bao giờ đã kịp kéo nỗi buồn sắp làm thành tổ đi về phía yêu thương. Yêu thương mong manh, yêu thương từ những con phố nhỏ, phố lạ rồi phố bỗng thành quen, phố giữ kỷ niệm hai đứa tay trong tay ấm áp, là bờ vai ai run run, là tim ai rung lên từng nhịp nhớ thương.",
        content: '<p><br />
          <em><font face="Arial">C&oacute; một thời em y&ecirc;u hoa thạch thảo</font><br />
          <font face="Arial">Để cả một đời phải thương nhớ đợi chờ</font></em><br />
          <br />
          <font face="Arial">Anh! H&agrave; Nội của t&igrave;nh y&ecirc;u em vẫn giữ trọn trong tr&aacute;i tim m&igrave;nh. H&agrave; Nội m&ugrave;a n&agrave;y nhuộm t&iacute;m cả khoảng trời b&igrave;nh lặng, nhuộm nỗi nhớ se sắt về anh từ cơn gi&oacute; heo may mang mưa đến gieo m&igrave;nh tr&ecirc;n ng&otilde; vắng. Ở nơi đ&oacute;, c&oacute; đẹp nhẹ nh&agrave;ng, c&oacute; nồng n&agrave;n như ở H&agrave; Nội những m&ugrave;a trước kh&ocirc;ng anh. Thế nhưng, em vẫn cứ muốn dựa v&agrave;o bờ vai anh để t&igrave;m ch&uacute;t hơi ấm ng&agrave;y gi&oacute; m&ugrave;a về. Em cứ muốn nắm chặt tay anh để những kẽ hở ấy được lấp đầy v&agrave; em cứ muốn &ocirc;m anh, để được lắng nghe tiếng con tim đang đập những nhịp thật nhanh, để biết m&igrave;nh đ&atilde; từng y&ecirc;u nhau nhiều như thế n&agrave;o giữa th&agrave;nh phố ngh&igrave;n năm tuổi đ&oacute;.</font><br />
          <br />
          <font face="Arial">M&ugrave;a n&agrave;o H&agrave; Nội cũng l&agrave; m&ugrave;a y&ecirc;u, chỉ l&agrave; m&igrave;nh y&ecirc;u nhau như thế n&agrave;o v&agrave; em vẫn y&ecirc;u anh như y&ecirc;u một m&ugrave;a thạch thảo t&iacute;m d&ugrave; m&igrave;nh đang ở ngay đ&acirc;y hay một người b&ecirc;n n&agrave;y, một người thế giới b&ecirc;n kia bởi khoảng c&aacute;ch xa nhất kh&ocirc;ng phải l&agrave; khi kh&ocirc;ng c&ograve;n được thấy nhau, khi một người gọi m&agrave; người chẳng thể trả lời; khi m&agrave; giọt nước mắt rơi v&igrave; sinh ly tử biệt đắng cay m&agrave; l&agrave; khi lướt qua nhau đ&atilde; chẳng c&ograve;n c&oacute; nhau.</font><br />
          <br />
          <font face="Arial">Anh hỏi em th&iacute;ch m&ugrave;a n&agrave;o nhất trong năm. Em đưa tay chỉ về khoảng trời c&oacute; ch&uacute;t nắng cuối thu, ch&uacute;t gi&oacute; lạnh đầu đ&ocirc;ng th&aacute;ng 11 về.</font><br />
          <br />
          <font face="Arial">Anh lại hỏi em th&iacute;ch lo&agrave;i hoa n&agrave;o nhất. Em sẽ chẳng cần phải suy nghĩ m&agrave; trả lời anh ngay rằng chỉ c&oacute; thể l&agrave; thạch thảo, giữa mu&ocirc;n lo&agrave;i hoa khoe sắc, rực hương, em lại th&iacute;ch nhất c&uacute;c c&aacute;nh mối.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt="Hà Nội tháng 11 tím rực trong tim" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_11/Ngay_10/Images/ha-noi-thang-11-ruc-tim-trong-tim1.jpg" /></font></p>

          <p><br />
          <font face="Arial">V&agrave; anh hỏi, l&agrave; em th&iacute;ch m&agrave;u t&iacute;m của hoa? Em mỉm cười n&acirc;ng hoa. Th&acirc;n thảo khẳng khiu, đ&oacute;a hoa nho nhỏ, c&aacute;nh hoa mỏng tang n&eacute;p m&igrave;nh ấy nhưng lại c&oacute; một sức sống bền bỉ v&agrave; m&atilde;nh liệt để người với người chẳng bao giờ hết y&ecirc;u nhau.</font><br />
          <br />
          <font face="Arial"><strong>H&agrave; Nội th&aacute;ng 11,</strong>&nbsp;trời đang chuyển m&igrave;nh những ng&agrave;y cuối thu đầu đ&ocirc;ng với cơn mưa lạnh. Chợt nhận ra từ l&uacute;c n&agrave;o, h&agrave;ng c&acirc;y trước nh&agrave; đ&atilde; tr&uacute;t l&aacute; v&agrave;ng rải thảm, nắng mỏng như lụa chỉ c&ograve;n vương lại ph&iacute;a những c&agrave;nh cao xa t&iacute;t, gi&oacute; c&oacute; ch&uacute;t hanh hao r&ugrave;ng m&igrave;nh khi lướt qua da mặt. Những lời hứa chưa trọn đ&atilde; gi&agrave; đi theo năm th&aacute;ng, những ch&ocirc;ng ch&ecirc;nh hoang hoải cho m&ugrave;a đ&atilde; cũ nay cuộn t&igrave;m về đ&acirc;u?</font><br />
          <br />
          <font face="Arial"><strong>H&agrave; Nội th&aacute;ng 11</strong>, người ta th&igrave; thầm khẽ với nhau rằng c&oacute; một lo&agrave;i hoa n&eacute;p m&igrave;nh khi&ecirc;m nhường tr&ecirc;n phố với sắc t&iacute;m nhẹ nh&agrave;ng &quot;t&igrave;nh y&ecirc;u thủy chung t&iacute;m biếc thạch thảo&quot; như cho&agrave;ng lấy từng con đường quen thuộc, đổ v&agrave;o l&ograve;ng người ch&uacute;t x&ocirc;n xao kh&oacute; tả. Lo&agrave;i hoa n&agrave;y kh&ocirc;ng đẹp, m&ugrave;i hương cũng kh&ocirc;ng quyến rũ nhưng sắc t&iacute;m man m&aacute;c v&agrave; xưa cũ, một vẻ đẹp mộc mạc, giản dị ch&acirc;n th&agrave;nh, chỉ cần ngắm nh&igrave;n những c&aacute;nh hoa b&eacute; x&iacute;u n&eacute;p m&igrave;nh tr&ecirc;n g&aacute;nh h&agrave;ng rong đi dưới phố bỗng thấy t&acirc;m hồn m&igrave;nh b&igrave;nh y&ecirc;n hơn.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt="Hà Nội tháng 11 tím rực trong tim" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_11/Ngay_10/Images/ha-noi-thang-11-ruc-tim-trong-tim2.jpg" /></font></p>

          <p><br />
          <font face="Arial"><strong>H&agrave; Nội th&aacute;ng 11,&nbsp;</strong>hoa c&oacute; điểm chung l&agrave; nhanh đến, nhanh đi. Thạch thảo c&oacute; hoa quanh năm nhưng nở rộ trong v&agrave;i ba tuần, khi c&aacute;c lo&agrave;i hoa kh&aacute;c bắt đầu rụng c&aacute;nh, xanh xao v&agrave; trước khi gi&oacute; đ&ocirc;ng tr&agrave;n về tr&ecirc;n phố th&igrave; thạch thảo lại t&iacute;m biếc tr&ecirc;n những giỏ xe người thiếu nữ. Thạch thảo thuộc họ C&uacute;c c&ograve;n được gọi l&agrave; C&uacute;c Sao, C&uacute;c C&aacute;nh mối, người H&agrave; Nội gọi l&agrave; Thạch Thảo. V&agrave; những đ&ocirc;i t&igrave;nh nh&acirc;n trẻ thường tặng cho nhau lo&agrave;i hoa n&agrave;y để rồi sẽ m&atilde;i m&atilde;i kh&ocirc;ng qu&ecirc;n nhau, sẽ lu&ocirc;n ở b&ecirc;n nhau. &Ocirc;m trọn b&oacute; hoa trong tay c&oacute; cảm gi&aacute;c như m&igrave;nh đang &ocirc;m hết những b&igrave;nh y&ecirc;n, dịu ngọt. Chẳng hiểu v&igrave; sao lo&agrave;i hoa nhỏ b&eacute; ấy lại khiến người ta động l&ograve;ng đến vậy. Chạm v&agrave;o những c&aacute;nh t&iacute;m mỏng manh kia l&agrave; l&ograve;ng lại gợn l&ecirc;n một nỗi nhớ mơ hồ về t&igrave;nh y&ecirc;u của một đ&ocirc;i trai g&aacute;i t&ecirc;n l&agrave; Ami v&agrave; Edible. Để mang được lo&agrave;i hoa y&ecirc;u th&iacute;ch về cho người con g&aacute;i m&igrave;nh y&ecirc;u, ch&agrave;ng trai đ&atilde; phải đ&aacute;nh đổi bằng cả sinh mạng của m&igrave;nh nhưng người ta tin rằng cho đến một ng&agrave;y họ đ&atilde; gặp được nhau v&agrave; họ l&agrave; của nhau m&atilde;i m&atilde;i.</font><br />
          <br />
          <font face="Arial"><strong>H&agrave; Nội th&aacute;ng 11, những ng&agrave;y trở gi&oacute; l&agrave; c&ocirc; đơn t&igrave;m về cứ bon chen len v&agrave;o mọi ng&oacute;c ng&aacute;ch trong tim; l&agrave; c&oacute; đ&ocirc;i b&agrave;n tay đưa ra nhưng chẳng muốn nắm bởi c&ocirc; đơn từ bao giờ đ&atilde; kịp k&eacute;o nỗi buồn sắp l&agrave;m th&agrave;nh tổ đi về ph&iacute;a y&ecirc;u thương. Y&ecirc;u thương mong manh, y&ecirc;u thương từ những con phố nhỏ, phố lạ rồi phố bỗng th&agrave;nh quen, phố giữ kỷ niệm hai đứa tay trong tay ấm &aacute;p, l&agrave; bờ vai ai run run, l&agrave; tim ai rung l&ecirc;n từng nhịp nhớ thương</strong>. Bỗng thấy H&agrave; Nội ng&agrave;y trở gi&oacute; mang đến ch&uacute;t g&igrave; đ&oacute; hanh hao kh&ocirc;ng phải của nắng cũng kh&ocirc;ng phải của gi&oacute; m&agrave; l&agrave; của l&ograve;ng người lặng một khoảng kh&eacute;p m&igrave;nh co ro một g&oacute;c, để siết chặt nỗi nhớ về anh. Chờ mong H&agrave; Nội gọi gi&oacute; về, gọi y&ecirc;u thương vọng lại theo tiếng l&aacute; rơi x&agrave;o xạc dưới bước ch&acirc;n ai, cho sắc t&iacute;m m&ecirc;nh mang đến lạ kỳ. V&agrave; chờ mong H&agrave; Nội gọi nỗi nhớ ch&ecirc;nh chao, loay hoay với những điều nay đ&atilde; cũ.</font><br />
          <br />
          <font face="Arial"><strong>&copy; H&agrave;ng X&oacute;m &ndash; blogradio.vn</strong></font></p>
          ',
        status: :accepted,
        user_id: 12,
        category_id: 20,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/5.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      Post.create(
        post_type: :normal,
        title: "Anh vẫn chưa là của ai nhưng cũng không thuộc về em",
        description: "Anh nói “Em buông tay đi, rồi em sẽ ổn, rồi sẽ có người thay thế anh yêu em và yêu em nhiều hơn anh từng yêu”. Em cũng hi vọng điều ấy lắm, nhưng thời gian càng trôi đi, em vẫn không thấy người ấy đâu anh. Em đã từ chối tất cả chỉ để dành thời gian nghĩ về anh và trớ trêu thay đấy chính là điều em đang làm để hạnh hạ bản thân. Anh vẫn chưa là của ai, nhưng anh vẫn không là của em. Em chỉ biết có thế nhưng không muốn chấp nhận thế",
        content: '<p><font face="Arial">Tr&aacute;i tim em bất chợt rung động, bất chợt loạn nhịp trước &aacute;nh mắt v&agrave; nụ cười ấy một c&aacute;ch rất kh&ocirc;ng thể ngờ tới. Anh đến b&ecirc;n em như một định mệnh được sắp đặt sẵn m&agrave; đến cả em v&agrave; anh chưa bao giờ nghĩ đến.</font><br />
          <br />
          <font face="Arial">Khi con người ta y&ecirc;u, họ chỉ nh&igrave;n được cả thế giới qua người m&igrave;nh y&ecirc;u, họ chỉ nghĩ rằng tr&ecirc;n thế gian n&agrave;y chỉ c&oacute; họ v&agrave; người ấy để rồi ch&iacute;m đắm trong men t&igrave;nh v&agrave; thăng hoa trong hạnh ph&uacute;c. Họ qu&ecirc;n đi những x&aacute;o trộn ngo&agrave;i cuộc sống, qu&ecirc;n lu&ocirc;n những con người vẫn đang dần qua lại tr&ecirc;n phố, họ qu&ecirc;n tất cả để chỉ d&agrave;nh t&acirc;m tr&iacute; nhớ đến một người duy nhất đang b&ecirc;n cạnh họ.</font><br />
          <br />
          <font face="Arial">Y&ecirc;u! Em đ&atilde; y&ecirc;u anh bằng cả con tim rất ch&acirc;n thật. Để rồi anh rời xa em v&agrave; d&agrave;nh lại cho em một nỗi đau m&agrave; em chưa bao giờ phải nếm trải.</font><br />
          <br />
          <font face="Arial">Em c&oacute; qu&aacute; bảo thủ với x&atilde; hội kh&ocirc;ng, khi em n&oacute;i rằng em l&agrave; người sai v&agrave; em l&agrave; người đ&atilde; l&agrave;m mọi chuyện rối ren.</font><br />
          <br />
          <font face="Arial">Em c&oacute; qu&aacute; bảo thủ với x&atilde; hội kh&ocirc;ng, khi em tự nhận hết mọi đau khổ về m&igrave;nh m&agrave; kh&ocirc;ng chịu san sẻ cho anh, để rồi người ta nh&igrave;n v&agrave;o em bằng &aacute;nh mắt đầy-thương-hại.</font><br />
          <br />
          <font face="Arial">Đ&uacute;ng, em qu&aacute; bảo thủ m&agrave;!</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_11/Ngay_10/Images/anh-da-khong-con-la-cua-em.jpg" /></font></p>

          <p><br />
          <font face="Arial">Em bảo thủ đến nỗi hằng ng&agrave;y, hằng đ&ecirc;m tự nhốt m&igrave;nh lại trong c&aacute;i v&ograve;ng luẩn quẩn của y&ecirc;u v&agrave; kh&ocirc;ng y&ecirc;u rồi dằn vặt bản th&acirc;n. Anh c&oacute; thấy ai ngốc như em kh&ocirc;ng anh? Chỉ c&oacute; con ngốc mới y&ecirc;u theo c&aacute;ch ngốc nghếch như thế anh nhỉ?</font><br />
          <br />
          <font face="Arial">Khi b&ecirc;n anh, em thấy cả thế giới n&agrave;y đều mang một m&agrave;u hồng đẹp tinh kh&ocirc;i v&agrave; mỹ miều đến bao nhi&ecirc;u th&igrave; khi rời xa anh n&oacute; u &aacute;m, hoang lạnh đến bấy nhi&ecirc;u.</font><br />
          <br />
          <font face="Arial">Khi rời xa anh em mới biết được rằng t&igrave;nh cảm con người l&agrave; thứ kh&ocirc;ng thể điều khiển được.</font><br />
          <br />
          <font face="Arial">Em lu&ocirc;n tự m&igrave;nh dặn l&ograve;ng, cứ h&atilde;y sống vui vẻ v&agrave; thật hạnh ph&uacute;c đừng bao giờ buồn v&igrave; một người kh&ocirc;ng xứng đ&aacute;ng.</font><br />
          <br />
          <font face="Arial">Em lu&ocirc;n tự dặn m&igrave;nh rằng, trong thế giới hơn 7 tỷ người kia sẽ c&oacute; một người cần đến em v&agrave; y&ecirc;u thương em.</font><br />
          <br />
          <font face="Arial">Thế nhưng c&agrave;ng cố gắng qu&ecirc;n anh em lại c&agrave;ng nhớ anh nhiều hơn. Em đau, nỗi đau ấy cứ b&aacute;m theo theo. Anh vẫn chưa l&agrave; của ai, nhưng anh vẫn kh&ocirc;ng l&agrave; của em. Em chỉ biết c&oacute; thế nhưng kh&ocirc;ng muốn chấp nhận thế. Anh đ&atilde; v&ocirc; t&acirc;m bỏ lại em nơi n&agrave;y với những rối ren trong l&ograve;ng với cả một vết thương kh&oacute; l&agrave;nh đến vậy, anh n&agrave;o đ&acirc;u biết được răng em đang rất y&ecirc;u v&agrave; nhớ anh đến v&ocirc; c&ugrave;ng.</font><br />
          <br />
          <font face="Arial">Anh n&oacute;i &ldquo;Em bu&ocirc;ng tay đi, rồi em sẽ ổn, rồi sẽ c&oacute; người thay thế anh y&ecirc;u em v&agrave; y&ecirc;u em nhiều hơn anh từng y&ecirc;u&rdquo;. Em cũng hi vọng điều ấy lắm, nhưng thời gian c&agrave;ng tr&ocirc;i đi, em vẫn kh&ocirc;ng thấy người ấy đ&acirc;u anh. Em đ&atilde; từ chối tất cả chỉ để d&agrave;nh thời gian nghĩ về anh v&agrave; trớ tr&ecirc;u thay đấy ch&iacute;nh l&agrave; điều em đang l&agrave;m để hạnh hạ bản th&acirc;n.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_11/Ngay_10/Images/anh-da-khong-con-la-cua-em1.jpg" /></font></p>

          <p><br />
          <font face="Arial">Em l&agrave; c&ocirc; g&aacute;i anh từng biết rất mạnh mẽ, em hiểu điều đ&oacute;. Nhưng anh ch&iacute;nh l&agrave; người cướp đi tất cả, cướp đi cả sự mạnh mẽ c&ograve;n s&oacute;t lại trong em. Con g&aacute;i m&agrave; anh, d&ugrave; em c&oacute; mạnh mẽ đến nhường n&agrave;o đi chăng nữa đ&oacute; cũng chỉ l&agrave; vỏ bọc giả tạo em d&ugrave;ng để che mắt thi&ecirc;n hạ th&ocirc;i.</font><br />
          <br />
          <font face="Arial">Thực ra, nỗi đau n&agrave;o cũng sẽ qua, vết thương n&agrave;o rồi cũng sẽ l&agrave;nh, c&oacute; c&ograve;n th&igrave; cũng chỉ l&agrave; những vết sẹo, em tin n&oacute; cũng sẽ mờ dần theo năm th&aacute;ng. Anh cũng l&agrave; người ngang qua đời em, anh l&agrave; m&acirc;y l&agrave; gi&oacute; cũng kh&ocirc;ng d&agrave;nh cho em. Bởi m&acirc;y của trời để gi&oacute; cuốn đi. Nếu l&agrave; gi&oacute; th&igrave; chỉ l&agrave; thoảng qua b&ecirc;n tai rồi tạo cho ta cảm gi&aacute;c m&aacute;t lạnh khi ấy đ&ocirc;i ch&uacute;t chứ gi&oacute; bận cuốn m&acirc;y theo trời rồi. Nếu l&agrave; một cơn mưa, th&igrave; anh chỉ đến b&ecirc;n đời ta một c&aacute;ch bất chợt rồi cũng sẽ bất chợt đi th&ocirc;i, c&oacute; đời n&agrave;o mưa m&atilde;i được đ&acirc;u. H&atilde;y cứ vững t&acirc;m tin rằng &ldquo;sau cơn mưa trời sẽ s&aacute;ng&rdquo; chỉ c&oacute; thiếu &aacute;nh nắng mặt trời ch&uacute;ng ta mới chết chứ thiếu mưa đ&acirc;u c&oacute; sao nhỉ.</font><br />
          <br />
          <font face="Arial">Thế đấy, t&igrave;nh y&ecirc;u m&agrave;, khi y&ecirc;u ta cứ ch&aacute;y bỏng hết m&igrave;nh đi, nhưng khi n&oacute; qua rồi cứ để n&oacute; nhẹ nh&agrave;ng tr&ocirc;i qua m&agrave; đừng cố gắng v&ugrave;ng vẫy v&agrave;o vũng nước ấy chỉ khiến nước tung t&oacute;e ra th&ocirc;i v&agrave; người đau lại l&agrave; người cuối c&ugrave;ng ở lại&hellip;</font><br />
          <br />
          <font face="Arial"><strong>&copy; Ngọc Băng &ndash; blogradio.vn</strong></font></p>
          ',
        status: :accepted,
        user_id: 11,
        category_id: 11,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/6.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      Post.create(
        post_type: :normal,
        title: "Có một Hà Nội bình yên trong tôi",
        description: "Tôi tìm một Hà Nội thân quen chẳng phải la đang đi tìm chính mình sao. Tìm lại mình giữa cuộc sống đầy bon chen này để nhận ra rằng, tôi yêu Hà Nội, tôi hòa nhập cùng Hà Nội, nhưng tôi vẫn là tôi và yêu mảnh đất này nhiều giống như yêu quê hương mình không phải là cái tội.",
        content: '<p><font face="Arial">Cơn gi&oacute; hờ hững những ng&agrave;y đầu đ&ocirc;ng, kho&aacute;c th&ecirc;m một tấm &aacute;o rồi bước ra ngo&agrave;i. C&oacute; một l&ograve;ng H&agrave; Nội vẫn b&igrave;nh y&ecirc;n thế, cảm nhận H&agrave; Nội theo một c&aacute;ch rất ri&ecirc;ng, c&oacute; lẽ cũng y&ecirc;u H&agrave; Nội nhiều hơn bởi thời tiết y&ecirc;n ả như thế n&agrave;y.</font><br />
          <br />
          <font face="Arial"><strong>T&ocirc;i t&igrave;m một H&agrave; Nội th&acirc;n quen trong t&aacute;n bằng lăng t&iacute;m ngắt khoảng trời</strong>. Độ th&aacute;ng bảy, l&agrave; thời gian bằng lăng rộ nhiều v&agrave; đẹp nhất. C&oacute; cơn mưa m&ugrave;a hạ n&agrave;o gh&eacute; ngang qua trong đ&ecirc;m, s&aacute;ng thức giấc, tản bộ tr&ecirc;n con đường th&acirc;n quen, chỉ thấy sắc trời thật dịu hiền, c&aacute;nh bằng lăng rụng v&igrave; cơn mưa đ&ecirc;m qua vương đầy lối nhỏ. C&aacute;nh hoa rụng nhưng cũng chẳng ch&uacute;t yếu ớt m&agrave; vẫn tươi tắn lạ k&igrave;, c&oacute; lẽ bởi, n&oacute; đ&atilde; sống v&agrave; l&agrave;m đẹp cho th&agrave;nh phố n&agrave;y trong những ng&agrave;y qua, vậy l&agrave; đủ rồi.</font><br />
          <br />
          <font face="Arial"><strong>T&ocirc;i t&igrave;m một H&agrave; Nội th&acirc;n quen nơi mặt hồ Gươm gợn nhẹ s&oacute;ng nước xanh rờn.&nbsp;</strong>T&igrave;m về hồ Gươm, cũng l&agrave; t&igrave;m về với những mảnh gh&eacute;p của lịch sử, năm th&aacute;ng đ&atilde; tr&ocirc;i qua nhưng những chứng t&iacute;ch lịch sử th&igrave; vẫn c&ograve;n đ&acirc;y. Hồ Gươm l&agrave; biểu tượng bất diệt của H&agrave; Nội, l&agrave; tr&aacute;i tim của thủ đ&ocirc;, l&agrave; nơi ta sẽ t&igrave;m thấy sự b&igrave;nh y&ecirc;n v&agrave; thanh thản đến diệu k&igrave; v&agrave;o tiết trời chớm lạnh như thế n&agrave;y. C&oacute; ch&uacute;t g&igrave; đ&oacute; l&agrave; sự cổ k&iacute;nh t&acirc;m linh, c&oacute; ch&uacute;t g&igrave; đ&oacute; sức sống trong những ng&agrave;y th&agrave;nh phố đổi mới kh&ocirc;ng ngừng. Mọi thứ đều chuyển rời, chỉ c&oacute; mặt hồ vẫn b&igrave;nh y&ecirc;n thế.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt="Có một Hà Nội bình yên trong tôi " src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_11/Ngay_4/Images/co-mot-ha-noi-binh-yen-trong-toi.jpg" /></font></p>

          <p><br />
          <font face="Arial"><strong>T&ocirc;i t&igrave;m một H&agrave; Nội th&acirc;n quen, nơi con đường Phan Đ&igrave;nh Ph&ugrave;ng cuối thu l&aacute; v&agrave;ng rơi đ&ocirc;i ngả.</strong>&nbsp;Nhất l&agrave; khi th&agrave;nh phố đ&atilde; về khuya, những ngọn đ&egrave;n đường chiếu s&aacute;ng b&ecirc;n đường, nơi n&agrave;y chợt trở n&ecirc;n đẹp đến lạ k&igrave;. M&agrave; từ trước giờ người H&agrave; Nội cũng vẫn lu&ocirc;n tự h&agrave;o v&igrave; con đường m&agrave;. Chợt nghĩ cũng thấy lạ, tại sao kh&ocirc;ng biến những con đương kh&aacute;c trở th&agrave;nh những con đường đẹp v&agrave; &ecirc;m ả như thế n&agrave;y nhỉ? Nhưng k&igrave; thực, m&igrave;nh chỉ nghĩ ra được, nhưng m&igrave;nh kh&ocirc;ng l&agrave;m được.</font><br />
          <br />
          <font face="Arial"><strong>T&ocirc;i t&igrave;m một H&agrave; Nội th&acirc;n quen nơi những qu&aacute;n vỉa h&egrave; v&agrave;o buổi đ&ecirc;m c&agrave;ng trở n&ecirc;n nhộn nhịp.</strong>&nbsp;C&oacute; một H&agrave; Nội h&agrave;o sảng v&agrave; ph&oacute;ng kho&aacute;ng như thế. Người ta gọi một ly tr&agrave; đ&aacute;, một cốc tr&agrave; chanh, một đĩa hướng dương rồi ngồi n&oacute;i với nhau dăm ba c&acirc;u chuyện, chuyện đời, chuyện người, rồi cả những c&acirc;u chuyện về một đất nước xa x&ocirc;i n&agrave;o kia,&hellip; Những cuộc n&oacute;i chuyện cứ k&eacute;o d&agrave;i thế, ng&agrave;y qua ng&agrave;y họ hẹn gặp nhau, vẫn tại qu&aacute;n n&agrave;y, vẫn thức uống n&agrave;y,&hellip; nhưng l&agrave; một c&acirc;u chuyện với những điều mới mẻ hơn. Vậy mới n&oacute;i, c&oacute; những mối quan hệ mặc d&ugrave; đ&atilde; rất l&acirc;u nhưng ch&uacute;ng ta kh&ocirc;ng bao giờ thấy ch&aacute;n.</font><br />
          <br />
          <font face="Arial">T&ocirc;i t&igrave;m một H&agrave; Nội th&acirc;n quen chẳng phải la đang đi t&igrave;m ch&iacute;nh m&igrave;nh sao. T&igrave;m lại m&igrave;nh giữa cuộc sống đầy bon chen n&agrave;y để nhận ra rằng, t&ocirc;i y&ecirc;u H&agrave; Nội, t&ocirc;i h&ograve;a nhập c&ugrave;ng H&agrave; Nội, nhưng t&ocirc;i vẫn l&agrave; t&ocirc;i v&agrave; y&ecirc;u mảnh đất n&agrave;y nhiều giống như y&ecirc;u qu&ecirc; hương m&igrave;nh kh&ocirc;ng phải l&agrave; c&aacute;i tội.</font><br />
          <br />
          <font face="Arial"><strong>&copy; Minh Hi&ecirc;n &ndash; blogradio.vn</strong></font></p>
          ',
        status: :accepted,
        user_id: 13,
        category_id: 12,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/7.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      Post.create(
        post_type: :normal,
        title: "Hãy là con gái chứ không phải là bánh bèo vô dụng",
        description: "Con gái mạnh mẽ, độc lập biết rằng cuộc sống không phải là những câu chuyện cổ tích để mơ mộng mà là những thử thách để vượt qua và trưởng thành hơn mỗi ngày dù đó có là các mối quan hệ bạn bè, tình cảm hay công việc đi chăng nữa. Thực tế là cách duy nhất để bạn có thể thực sự cảm thấy hạnh phúc.",
        content: '<p><font face="Arial"><strong>1. Tự tạo niềm vui cho m&igrave;nh</strong></font><br />
          <br />
          <font face="Arial">Điều tuyệt vời nhất của c&ocirc; g&aacute;i ch&iacute;nh l&agrave; cuộc sống n&agrave;y lu&ocirc;n vui vẻ v&agrave; tr&agrave;n ngập tiếng cười. Học c&aacute;ch để tự tạo niềm vui cho ch&iacute;nh m&igrave;nh, thỏa m&atilde;n những g&igrave; m&igrave;nh muốn v&agrave; bỏ qua hết những buồn phiền đi, đ&oacute; mới l&agrave; cuộc sống đ&iacute;ch thực đ&oacute;.</font><br />
          <br />
          <font face="Arial"><strong>2. H&atilde;y t&ocirc;n trọng ch&iacute;nh m&igrave;nh</strong></font><br />
          <br />
          <font face="Arial">Tr&ecirc;n tất cả, bạn phải tự y&ecirc;u qu&yacute; v&agrave; tr&acirc;n trọng ch&iacute;nh bản th&acirc;n m&igrave;nh. V&igrave; nếu bạn kh&ocirc;ng tr&acirc;n trọng m&igrave;nh th&igrave; chẳng ai c&oacute; thể l&agrave;m như vậy.</font><br />
          <br />
          <font face="Arial"><strong>3. Lu&ocirc;n giữ cho vẻ bề ngo&agrave;i c&acirc;n đối v&agrave; khỏe mạnh</strong></font><br />
          <br />
          <font face="Arial">Để trở th&agrave;nh một người con g&aacute;i mạnh mẽ, độc lập th&igrave; kh&ocirc;ng chỉ l&agrave; việc chăm lo về mặt tinh thần m&agrave; bạn c&ograve;n phải c&oacute; một vẻ ngo&agrave;i v&agrave; sức khỏe thực sự vững v&agrave;ng. H&atilde;y đến ph&ograve;ng tập gym, ăn những thực phẩm tốt cho sức khỏe v&agrave; bạn sẽ cảm thấy tự tin hơn mỗi ng&agrave;y.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt=" Hãy là con gái chứ không phải là bánh bèo vô dụng" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_10/Ngay_24/Images/hay-la-con-gai-chu-khong-phai-banh-beo-vo-dung1.jpg" /></font></p>

          <p><br />
          <font face="Arial"><strong>4. H&atilde;y l&agrave;m việc thật chăm chỉ</strong></font><br />
          <br />
          <font face="Arial">Con g&aacute;i mạnh mẽ, độc lập kh&ocirc;ng chỉ ngồi đ&oacute; v&agrave; chờ đợi. Họ l&agrave;m việc chăm chỉ để theo đuổi những giấc mơ v&agrave; đam m&ecirc; của bản th&acirc;n.</font><br />
          <br />
          <font face="Arial"><strong>5. Đừng bao giờ đứng y&ecirc;n</strong></font><br />
          <br />
          <font face="Arial">D&ugrave; cho đ&oacute; l&agrave; c&ocirc;ng việc hay cuộc sống của bạn, đừng bao giờ đứng y&ecirc;n v&agrave; chấp nhận những điều nhỏ b&eacute; hơn những g&igrave; m&agrave; bạn xứng đ&aacute;ng c&oacute; được. Nếu kh&ocirc;ng thực sự cảm thấy vui vẻ v&agrave; hạnh ph&uacute;c, h&atilde;y bước tiếp.</font><br />
          <br />
          <font face="Arial"><strong>6. H&atilde;y thực tế trong cuộc sống v&agrave; c&aacute;c mối quan hệ</strong></font><br />
          <br />
          <font face="Arial">Con g&aacute;i mạnh mẽ, độc lập biết rằng cuộc sống kh&ocirc;ng phải l&agrave; những c&acirc;u chuyện cổ t&iacute;ch để mơ mộng m&agrave; l&agrave; những thử th&aacute;ch để vượt qua v&agrave; trưởng th&agrave;nh hơn mỗi ng&agrave;y d&ugrave; đ&oacute; c&oacute; l&agrave; c&aacute;c mối quan hệ bạn b&egrave;, t&igrave;nh cảm hay c&ocirc;ng việc đi chăng nữa. Thực tế l&agrave; c&aacute;ch duy nhất để bạn c&oacute; thể thực sự cảm thấy hạnh ph&uacute;c.</font><br />
          <br />
          <font face="Arial"><strong>7. H&atilde;y tr&aacute;nh xa sự bốc đồng</strong></font><br />
          <br />
          <font face="Arial">Bất kỳ một c&ocirc; n&agrave;ng độc lập n&agrave;o cũng đều suy nghĩ thật kỹ trước khi h&agrave;nh động d&ugrave; đ&oacute; l&agrave; chuyện nhỏ hay thực sự lớn. V&igrave; họ tin rằng: cuộc sống l&agrave; kết tinh của tất cả những quyết định, v&igrave; thế đừng bốc đồng với bất kỳ một sự lựa chọn n&agrave;o.</font><br />
          <br />
          <font face="Arial"><strong>8. H&atilde;y lờ đi những người chỉ mang đến sự ti&ecirc;u cực</strong></font><br />
          <br />
          <font face="Arial">Những kẻ ti&ecirc;u cực c&oacute; mặt ở khắp mọi nơi: từ trường học, c&ocirc;ng sở đến cả tr&ecirc;n c&aacute;c trang mạng x&atilde; hội m&agrave; bạn tham gia. V&agrave; c&aacute;c c&ocirc; n&agrave;ng mạnh mẽ, độc lập lu&ocirc;n chọn c&aacute;ch phớt lờ v&agrave; kh&ocirc;ng để lời n&oacute;i, h&agrave;nh động v&agrave; cả nguồn năng lượng ti&ecirc;u cực của những người n&agrave;y ảnh hưởng đến m&igrave;nh.</font><br />
          <br />
          <font face="Arial"><strong>9. C&oacute; một cuộc sống ri&ecirc;ng cho bản th&acirc;n</strong></font><br />
          <br />
          <font face="Arial">Đừng d&agrave;nh tất cả thời gian của m&igrave;nh để loay hoay b&ecirc;n cạnh một ai đ&oacute; hay một điều g&igrave; đ&oacute;. V&igrave; ai cũng cần c&oacute; một cuộc sống ri&ecirc;ng, một kh&ocirc;ng gian ri&ecirc;ng d&agrave;nh cho m&igrave;nh để nghỉ ngơi v&agrave; t&igrave;m lại hơi thở sau chuỗi ng&agrave;y tất bật với c&ocirc;ng việc v&agrave; c&aacute;c mối quan hệ. H&atilde;y c&oacute; một cuộc sống ri&ecirc;ng cho bản th&acirc;n v&agrave; bạn sẽ trở n&ecirc;n thực sự độc lập.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt=" Hãy là con gái chứ không phải là bánh bèo vô dụng" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_10/Ngay_24/Images/hay-la-con-gai-chu-khong-phai-banh-beo-vo-dung2.jpg" /></font></p>

          <p><br />
          <font face="Arial"><strong>10. Tự giải quyết mọi vấn đề c&aacute; nh&acirc;n của m&igrave;nh</strong></font><br />
          <br />
          <font face="Arial">Tuy hỏi &yacute; kiến hay tham khảo lời khuy&ecirc;n của người kh&aacute;c th&igrave; vẫn lu&ocirc;n cần thiết nhưng h&atilde;y nhớ rằng n&uacute;t do bạn thắt lại th&igrave; chỉ c&oacute; m&igrave;nh bạn c&oacute; thể gỡ ra được. Đừng bao giờ biến người kh&aacute;c th&agrave;nh c&ocirc;ng cụ r&agrave; so&aacute;t v&agrave; sửa lỗi cho mọi vấn đề của cuộc đời bạn.</font><br />
          <br />
          <font face="Arial"><strong>11. B&igrave;nh tĩnh. Phải lu&ocirc;n giữ được sự b&igrave;nh tĩnh</strong></font><br />
          <br />
          <font face="Arial">Ph&aacute;t đi&ecirc;n v&agrave; c&aacute;u tiết với một chuyện sai tr&aacute;i n&agrave;o đ&oacute; quả thật rất dễ d&agrave;ng, dễ hơn việc giữ b&igrave;nh tĩnh rất nhiều. Nhưng những c&ocirc; n&agrave;ng mạnh mẽ, độc lập th&igrave; kh&ocirc;ng l&agrave;m như vậy v&igrave; họ c&oacute; thể giải quyết tất cả mọi t&igrave;nh huống khủng khiếp nhất với một tr&aacute;i tim b&igrave;nh thản nhất v&agrave; một t&acirc;m thế đĩnh đạc nhất.</font><br />
          <br />
          <font face="Arial"><strong>12. H&atilde;y tự đứng l&ecirc;n v&igrave; m&igrave;nh khi cần thiết</strong></font><br />
          <br />
          <font face="Arial">Những c&ocirc; n&agrave;ng mạnh mẽ, độc lập lu&ocirc;n biết đứng l&ecirc;n để tự bảo vệ cho quyền lợi v&agrave; hạnh ph&uacute;c của ch&iacute;nh bản th&acirc;n m&igrave;nh chứ kh&ocirc;ng chỉ biết tr&ocirc;ng chờ v&agrave;o số phận hay v&agrave;o sức mạnh của người kh&aacute;c.</font><br />
          <br />
          <font face="Arial"><strong>13. C&oacute; thể tự l&agrave;m mọi thứ nếu c&oacute; thể</strong></font><br />
          <br />
          <font face="Arial">Đ&acirc;y l&agrave; c&aacute;ch m&agrave; bạn độc lập theo đ&uacute;ng nghĩa đen của từ n&agrave;y. H&atilde;y tự t&igrave;m kiếm v&agrave; mang đến cho m&igrave;nh bất cứ thứ g&igrave; m&agrave; bạn cần, dẫu đ&oacute; c&oacute; l&agrave; tiền bạc, một ng&ocirc;i nh&agrave; hay thậm ch&iacute; l&agrave; hạnh ph&uacute;c. Điều n&agrave;y cũng gi&uacute;p bạn c&oacute; thể đỡ đần cho gia đ&igrave;nh v&agrave; người đ&agrave;n &ocirc;ng m&igrave;nh y&ecirc;u thương, chứng minh cho anh ấy biết rằng bạn y&ecirc;u kh&ocirc;ng phải v&igrave; tiền t&agrave;i, danh vọng m&agrave; y&ecirc;u ch&iacute;nh con người anh ấy.</font><br />
          <br />
          <font face="Arial"><strong>Blog Radio Tổng hợp.</strong></font></p>
          ',
        status: :accepted,
        user_id: 11,
        category_id: 18,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/8.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      Post.create(
        post_type: :normal,
        title: "Những khoảnh khắc tuyệt vời của tình yêu mà cặp đôi nào cũng muốn trải qua",
        description: "Bạn bị đuổi việc, mất đi người thân, hay phải trải qua một cuộc phẫu thuật nguy hiểm - những điều này chả có gì tuyệt diệu cả, nhưng điều tuyệt diệu chính là bạn luôn có người kia bên cạnh.",
        content: '<p><br />
        <font face="Arial"><strong>1. Buổi hẹn h&ograve; đầu ti&ecirc;n</strong></font><br />
        <br />
        <font face="Arial">Bạn c&oacute; nhớ cảm gi&aacute;c hồi hộp khi đến gặp ch&agrave;ng trong buổi hẹn h&ograve; đầu ti&ecirc;n?</font><br />
        <br />
        <font face="Arial">Ngay cả khi đ&atilde; c&oacute; một lịch sử t&igrave;nh trường đủ để viết th&agrave;nh phim truyền h&igrave;nh, th&igrave; khoảnh khắc ch&uacute;ng ta quyết định mở cửa tr&aacute;i tim m&igrave;nh lần nữa, đ&aacute;nh cược lần nữa v&agrave; tin rằng m&igrave;nh sẽ may mắn vẫn thật tuyệt vời.</font><br />
        <br />
        <font face="Arial"><strong>2. Nụ h&ocirc;n đầu ti&ecirc;n</strong></font><br />
        <br />
        <font face="Arial">Bạn c&oacute; thể suy nghĩ về n&oacute; ngay lần đầu ti&ecirc;n nh&igrave;n thấy ch&agrave;ng, nhưng kh&ocirc;ng ai biết ch&iacute;nh x&aacute;c n&oacute; sẽ xảy ra ở đ&acirc;u, v&agrave;o l&uacute;c n&agrave;o v&agrave; bằng c&aacute;ch n&agrave;o.</font><br />
        <br />
        <font face="Arial"><strong>3. Lần c&atilde;i nhau đầu ti&ecirc;n</strong></font><br />
        <br />
        <font face="Arial">C&oacute; thể bạn thấy hơi lạ, nhưng đ&acirc;y cũng l&agrave; một khoảnh khắc ấn tượng đấy chứ. Chưa kể bạn c&ograve;n được &quot;tặng k&egrave;m&quot; th&ecirc;m một khoảnh khắc dễ thương nữa: Khi cả hai quyết định l&agrave;m l&agrave;nh.</font><br />
        <br />
        <font face="Arial"><strong>4. Lần đầu ti&ecirc;n đi qu&aacute; 12 giờ đ&ecirc;m</strong></font><br />
        <br />
        <font face="Arial">Trong truyện, khi Lọ Lem nghe đồng hồ b&aacute;o nửa đ&ecirc;m th&igrave; lập tức bỏ hết tất cả (kể cả ho&agrave;ng tử đẹp trai) để quay về, c&ograve;n bạn th&igrave; sao? Trước khi đưa ra quyết định, hẳn bạn sẽ trải qua một cuộc đấu tranh nội t&acirc;m đầy gay cấn.</font><br />
        &nbsp;</p>

        <p><font face="Arial"><img alt="Những khoảnh khắc tuyệt vời của tình yêu mà cặp đôi nào cũng muốn trải qua" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_11/Ngay_1/Images/nhung-khoanh-khac-tuyet-voi-ma-cap-doi-yeu-nhau-deu-muon-trai-qua1.jpg" /></font></p>

        <p><br />
        <font face="Arial"><strong>5. Khi c&ugrave;ng nằm tr&ecirc;n giường nhưng lại kh&ocirc;ng c&oacute; chuyện g&igrave; xảy ra</strong></font><br />
        <br />
        <font face="Arial">Cảm gi&aacute;c như &quot;A, m&igrave;nh kh&ocirc;ng chỉ c&oacute; một người y&ecirc;u m&agrave; c&ograve;n c&oacute; bạn tri kỷ&quot;, &quot;Th&igrave; ra anh ấy y&ecirc;u t&acirc;m hồn m&igrave;nh cũng như y&ecirc;u cơ thể m&igrave;nh&quot;. Tuy nhi&ecirc;n, nếu cứ lặp lại điều n&agrave;y 8000 lần, c&oacute; lẽ mối quan hệ của bạn đ&atilde; chuyển sang giai đoạn &quot;bạn gi&agrave; trong viện dưỡng l&atilde;o&quot;.</font><br />
        <br />
        <font face="Arial"><strong>6. Nhận ra gia đ&igrave;nh anh ấy cũng c&oacute; thể l&agrave; gia đ&igrave;nh m&igrave;nh</strong></font><br />
        <br />
        <font face="Arial">Đ&ocirc;i khi c&oacute; những gia đ&igrave;nh hơi k&igrave; lạ một ch&uacute;t, nhưng nếu bạn thấy th&acirc;n thuộc với gia đ&igrave;nh mới n&agrave;y, cảm gi&aacute;c thoải m&aacute;i như đang ở nh&agrave; m&igrave;nh quả l&agrave; tuyệt vời (tức l&agrave; mẹ ch&agrave;ng c&oacute; thể qu&aacute;t bạn đi rửa ch&eacute;n c&ograve;n c&ocirc; em ch&agrave;ng th&igrave; gi&agrave;nh laptop của bạn để chơi game chẳng hạn).</font><br />
        <br />
        <font face="Arial"><strong>7. Mua một c&aacute;i b&agrave;n chải đ&aacute;nh răng v&agrave; để ở nh&agrave; anh ấy</strong></font><br />
        <br />
        <font face="Arial">H&agrave;nh động n&agrave;y sẽ l&agrave; một lời ngầm đe dọa: &ldquo;Em c&oacute; thể đến bất cứ khi n&agrave;o em muốn, anh cẩn thận đi nh&aacute;&rdquo;. Thật ra theo một kh&iacute;a cạnh &iacute;t nguy hiểm hơn, điều n&agrave;y c&oacute; nghĩa bạn muốn d&agrave;nh nhiều thời gian ngọt ng&agrave;o b&ecirc;n nhau.</font><br />
        <br />
        <font face="Arial"><strong>8. Khi đang c&atilde;i nhau nảy lửa, v&agrave; bạn biết m&igrave;nh kh&ocirc;ng muốn chia tay ch&uacute;t n&agrave;o</strong></font><br />
        <br />
        <font face="Arial">Thoạt nghe như chuyện n&agrave;y kh&ocirc;ng n&ecirc;n c&oacute; trong danh s&aacute;ch &quot;khoảnh khắc tuyệt vời&quot;, nhưng qua trận c&atilde;i nhau tưng bừng đ&oacute; bạn mới biết m&igrave;nh thật sự kh&ocirc;ng muốn mất đi t&igrave;nh y&ecirc;u hiện tại.</font><br />
        <br />
        <font face="Arial"><strong>9. Khi bạn bất ngờ thốt l&ecirc;n &ldquo;em y&ecirc;u anh&rdquo; v&agrave; chờ b&ecirc;n kia đ&aacute;p lại</strong></font><br />
        <br />
        <font face="Arial">Trong lịch sử của nh&acirc;n loại, chưa từng c&oacute; trường hợp n&agrave;o hai người n&oacute;i c&acirc;u &ldquo;Anh y&ecirc;u em/ Em y&ecirc;u anh&rdquo; xong m&agrave; kh&ocirc;ng bị l&uacute;ng t&uacute;ng tự hỏi phải n&oacute;i g&igrave; tiếp theo. Th&ocirc;ng thường bạn sẽ n&oacute;i th&ecirc;m &ldquo;&Agrave;, &yacute; em l&agrave;...&rdquo; trong khi mắt liếc sang v&agrave; đợi ch&agrave;ng đ&aacute;p lại c&acirc;u tương tự (hoặc thế giới sẽ phải hứng chịu một cơn cuồng phong dữ dội).</font><br />
        &nbsp;</p>

        <p><font face="Arial"><img alt="Những khoảnh khắc tuyệt vời của tình yêu mà cặp đôi nào cũng muốn trải qua" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_11/Ngay_1/Images/nhung-khoanh-khac-tuyet-voi-ma-cap-doi-yeu-nhau-deu-muon-trai-qua2.jpg" /></font></p>

        <p><br />
        <font face="Arial"><strong>10. Khi y&ecirc;u nhau đ&atilde; l&acirc;u nhưng khi đi du lịch chung, bạn vẫn c&oacute; cảm gi&aacute;c như ng&agrave;y mới y&ecirc;u</strong></font><br />
        <br />
        <font face="Arial">Thậm ch&iacute; cảm gi&aacute;c n&agrave;y c&ograve;n mạnh mẽ hơn hồi c&ograve;n nhỏ, lần đầu ti&ecirc;n được gia đ&igrave;nh dắt đi biển nữa. (Tuy nhi&ecirc;n, sẽ thật buồn nếu t&igrave;nh huống l&agrave; &quot;y&ecirc;u nhau đ&atilde; rất l&acirc;u nhưng đ&acirc;y l&agrave; lần đầu ti&ecirc;n được đi du lịch c&ugrave;ng nhau&quot;).</font><br />
        <br />
        <font face="Arial"><strong>11. Khi bạn rơi v&agrave;o giai đoạn đầy kh&oacute; khăn của cuộc sống, v&agrave; nhận ra thật may mắn v&igrave; đ&atilde; c&oacute; ch&agrave;ng b&ecirc;n cạnh</strong></font><br />
        <br />
        <font face="Arial">Bạn bị đuổi việc, mất đi người th&acirc;n, hay phải trải qua một cuộc phẫu thuật nguy hiểm - những điều n&agrave;y chả c&oacute; g&igrave; tuyệt diệu cả, nhưng điều tuyệt diệu ch&iacute;nh l&agrave; bạn lu&ocirc;n c&oacute; người kia b&ecirc;n cạnh.</font><br />
        <br />
        <font face="Arial"><strong>12. Bất cứ khi n&agrave;o bạn thấy m&igrave;nh cần ở một m&igrave;nh</strong></font><br />
        <br />
        <font face="Arial">Chuyện n&agrave;y kh&ocirc;ng thường xảy ra lắm đ&acirc;u, n&ecirc;n nếu c&oacute;, h&atilde;y xem đ&oacute; l&agrave; một điều tuyệt vời.</font><br />
        <br />
        <font face="Arial"><strong>13. L&eacute;n xem điện thoại ch&agrave;ng v&agrave; thấy ch&iacute;nh m&igrave;nh trong ảnh nền</strong></font><br />
        <br />
        <font face="Arial">D&ugrave; rất c&oacute; thể ch&agrave;ng c&oacute; t&agrave;i ti&ecirc;n tri v&agrave; biết thế n&agrave;o bạn cũng xem l&eacute;n điện thoại.</font><br />
        <br />
        <font face="Arial"><strong>14. Lần đầu nấu cho ch&agrave;ng ăn</strong></font><br />
        <br />
        <font face="Arial">- Kết quả thảm hại, ch&agrave;ng vẫn cố ăn: Tuyệt!</font><br />
        <br />
        <font face="Arial">- Kết quả thảm hại v&agrave; ch&agrave;ng l&agrave; người xuống bếp: Rất tuyệt!</font><br />
        <br />
        <font face="Arial">- Kết quả thảm hại v&agrave; cả hai c&ugrave;ng đi ăn tiệm: V&ocirc; c&ugrave;ng tuyệt vời!</font><br />
        <br />
        <font face="Arial"><strong>Blog Radio sưu tầm v&agrave; tổng hợp.</strong></font></p>
        ',
        status: :accepted,
        user_id: 12,
        category_id: 20,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/9.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      Post.create(
        post_type: :normal,
        title: "Mong manh như hương ai quen dịu dàng thoáng qua",
        description: "Em vẫn sẽ tiếp tục bước đi trên con đường quen thuộc, vẫn ghé những quán cà phê chúng ta hay ngồi và làm những điều mà hai ta còn dang dở chưa thực hiện được. Và đến một ngày nào đó nếu em có sánh bước bên người con trai nào khác thì xin anh cũng đừng buồn. Em chỉ là muốn viết tiếp câu chuyện tình yêu của chúng ta, để nó có một kết thúc thật đẹp như anh từng mong muốn. Và em sẽ chẳng bao giờ quên anh. Em yêu anh cả trong cơn mơ, giữa ngập tràn những nỗi nhớ.",
        content: '<p><font face="Arial">Vậy l&agrave; thời gian anh rời xa em kh&ocirc;ng c&ograve;n t&iacute;nh bằng ng&agrave;y nữa m&agrave; được t&iacute;nh bằng năm rồi anh nhỉ. Mọi chuyện cứ ngỡ như mới h&ocirc;m qua đ&acirc;y th&ocirc;i, nhưng sao ngoảnh lại đ&atilde; l&agrave; dĩ v&atilde;ng. Thời gian đ&ocirc;i khi thật t&agrave;n nhẫn với ch&iacute;nh em. Hay ch&iacute;nh em đ&atilde; hờ hững với thời gian? Trong khi em vẫn c&ograve;n lưu giữ những ho&agrave;i niệm về anh th&igrave; h&igrave;nh b&oacute;ng anh đ&atilde; xa em m&atilde;i m&atilde;i. C&oacute; lẽ tại em cố chấp kh&ocirc;ng chịu bu&ocirc;ng bỏ hay v&igrave; t&igrave;nh y&ecirc;u em d&agrave;nh cho anh vẫn c&ograve;n. Để rồi h&ocirc;m nay, đi tr&ecirc;n con đường quen thuộc em với anh thường đi, bao kỉ niệm xưa cũ &ugrave;a về. Nước mắt em lại rơi v&igrave; những lầm lỡ xưa cũ đ&atilde; kh&ocirc;ng thể cho em cơ hội sửa chữa những sai lầm của một thời n&ocirc;ng nổi, bồng bột dại khờ.<br />
          <br />
          V&agrave; em biết, em c&ograve;n nợ anh một lời cảm ơn, một lời xin lỗi. Ba năm l&agrave; một khoảng thời gian kh&ocirc;ng d&agrave;i cũng kh&ocirc;ng ngắn nhưng cũng đủ để em dần qu&ecirc;n anh, x&oacute;a h&igrave;nh b&oacute;ng anh trong k&iacute; ức. Nhưng em biết s&acirc;u thẳm trong tr&aacute;i tim em, em vẫn nhớ anh nhiều lắm. Như người ta thường hay n&oacute;i: cố qu&ecirc;n l&agrave; sẽ nhớ, một nỗi nhớ v&ocirc; h&igrave;nh nhưng lại ngọt ng&agrave;o với bao k&iacute; ức...<br />
          <br />
          <em>&ldquo;Mong manh như hương ai quen dịu d&agrave;ng tho&aacute;ng qua&nbsp;<br />
          Khi em lang thang b&ecirc;n anh đường chiều nắng xa&nbsp;<br />
          Nghe trong tim em c&ograve;n mu&ocirc;n lời c&aacute;m ơn, lời xin lỗi&nbsp;<br />
          Run run đ&ocirc;i vai em đau ng&agrave;y n&agrave;o bước đi&nbsp;<br />
          Tin y&ecirc;u em trao cho anh mất đi sao đ&agrave;nh&nbsp;<br />
          Nghe bao y&ecirc;u thương l&acirc;u nay dặn l&ograve;ng cố qu&ecirc;n giờ lại thiết tha&rdquo;.</em></font><br />
          &nbsp;</p>

          <p><img alt="Mong manh như hương ai quen dịu dàng thoáng qua" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_10/Ngay_20/Images/mong-manh-tinh-ve-2.jpeg" /><br />
          &nbsp;</p>

          <p><font face="Arial">Anh c&oacute; biết kh&ocirc;ng, trước kia em kh&ocirc;ng bao giờ tin v&agrave;o số phận, em chỉ nghĩ rằng m&igrave;nh c&oacute; thể thay đổi mọi thứ chỉ cần cố gắng. Nhưng từ khi gặp anh, quen anh v&agrave; y&ecirc;u anh, em mới chợt nhận ra rằng c&oacute; những điều sẽ m&atilde;i m&atilde;i kh&ocirc;ng thể l&agrave; của m&igrave;nh cho d&ugrave; c&oacute; cố gắng đến bao nhi&ecirc;u cũng thế th&ocirc;i.<br />
          <br />
          <em>&ldquo;Long lanh sương ru trong đ&ecirc;m một m&agrave;u mắt n&acirc;u&nbsp;<br />
          &Aacute;nh mắt ấy vẫn chất chứa cả trời ước mơ&nbsp;<br />
          Em mơ tay trong tay nhau m&igrave;nh lại như chưa từng xa c&aacute;ch&nbsp;<br />
          Cho em h&ocirc;n đ&ocirc;i mi anh ướt bao đ&ecirc;m rồi&nbsp;<br />
          Cho em &ocirc;m bao c&ocirc; đơn thắt tim em gầy&nbsp;<br />
          Cho em y&ecirc;u anh hơn xưa ng&agrave;y buồn đ&atilde; qua lại c&oacute; nhau&rdquo;.</em><br />
          <br />
          C&oacute; đ&ocirc;i lần em ước kh&ocirc;ng c&oacute; m&agrave;n đ&ecirc;m bu&ocirc;ng xuống, hoặc đơn giản l&agrave; c&oacute; thể l&agrave;m việc cả ng&agrave;y cả đ&ecirc;m th&ocirc;i cũng được. Em muốn m&igrave;nh lu&ocirc;n bận rộn để th&ocirc;i nghĩ về anh. Khi m&agrave;n đ&ecirc;m bu&ocirc;ng xuống, trở về trong căn ph&ograve;ng quen thuộc, nỗi nhớ về anh lại khiến em đau l&ograve;ng. Đ&atilde; bao đ&ecirc;m em rơi nước mắt khi nh&igrave;n lại những bức h&igrave;nh của anh v&agrave; em. Em nhớ lắm. Nhớ những tin y&ecirc;u, nhớ những c&aacute;i &ocirc;m thật chặt giữa trời đ&ocirc;ng buốt gi&aacute;. Em vẫn c&ograve;n nhớ như in v&ograve;ng tay anh &ocirc;m siết lấy em thật chặt sau mỗi lần ch&uacute;ng ta xa c&aacute;ch. Em nhớ cả những m&ocirc;i h&ocirc;n nồng n&agrave;n ch&uacute;ng ta vội trao nhau giữa chốn đ&ocirc;ng người. Em nhớ lắm anh &agrave;. Trong mỗi giấc mơ của em lu&ocirc;n c&oacute; h&igrave;nh b&oacute;ng anh, v&agrave; em đ&atilde; lu&ocirc;n mỉm cười như thế, để rồi mỗi sớm mai tỉnh dậy kh&ocirc;ng c&oacute; anh b&ecirc;n cạnh, nước mắt em lại tu&ocirc;n rơi.<br />
          <br />
          Em vẫn kh&ocirc;ng tin được rằng anh đ&atilde; m&atilde;i m&atilde;i rời xa em thật rồi. &Aacute;nh mắt đ&oacute;, c&aacute;i nắm tay đ&oacute; vẫn theo em cho đến tận ng&agrave;y h&ocirc;m nay m&agrave; đ&ocirc;i lần em ngỡ đ&atilde; qu&ecirc;n thật rồi. Em y&ecirc;u anh cả trong giấc mơ lẫn hiện thực. Y&ecirc;u đến đau l&ograve;ng&hellip;Nhưng c&oacute; thể thay đổi được g&igrave; kh&ocirc;ng anh, c&oacute; thể ngược d&ograve;ng thời gian về qu&aacute; khứ để cho em chuộc lại lỗi lầm, mang anh quay về b&ecirc;n em kh&ocirc;ng anh? Em vẫn nhớ như in buổi chiều ng&agrave;y h&ocirc;m đ&oacute;, một buổi chiều thấm đẫm m&aacute;u v&agrave; nước mắt, một buổi chiều với những tiếng c&ograve;i xe h&uacute; inh ỏi. Bao đ&ecirc;m em giật m&igrave;nh tỉnh giấc v&igrave; mơ thấy buổi chiều định mệnh đ&oacute;. Gi&aacute; như em kh&ocirc;ng c&atilde;i nhau với anh, kh&ocirc;ng cố chấp v&agrave; đừng bu&ocirc;ng tay anh v&agrave; bỏ chạy th&igrave; c&oacute; lẽ ng&agrave;y h&ocirc;m đ&oacute; anh đ&atilde; kh&ocirc;ng rời xa em m&atilde;i m&atilde;i như thế. Em vẫn ho&agrave;i nghi t&igrave;nh y&ecirc;u của anh d&agrave;nh cho em, khi em trong thấy anh đi b&ecirc;n người cũ. Nếu như em chịu nghe anh n&oacute;i, nghe lời giải th&iacute;ch từ anh th&igrave; mọi chuyện đ&atilde; kh&ocirc;ng như thế.&nbsp;<br />
          <br />
          <em>&ldquo;Nhớ ng&agrave;y n&agrave;o m&igrave;nh giận hờn nhau ph&uacute;t ng&acirc;y khờ&nbsp;<br />
          Lời n&oacute;i lỡ mang đi t&igrave;nh y&ecirc;u tr&aacute;ch sao để mất nhau&nbsp;<br />
          Thế rồi một ng&agrave;y kia nhận ra biết ta vụng dại&nbsp;<br />
          Người đ&atilde; đến cho em qu&ecirc;n đi nỗi đau ng&agrave;y đ&oacute;&rdquo;&nbsp;</em><br />
          <br />
          Em đ&atilde; nghe đ&acirc;u đ&oacute; một c&acirc;u như thế n&agrave;y: &ldquo;Tạo h&oacute;a quyết định ai c&oacute; thể bước v&agrave;o cuộc đời ch&uacute;ng ta. Nhưng ch&uacute;ng ta mới l&agrave; người quyết định sẽ để ai ra đi, hay giữ b&ecirc;n m&igrave;nh. V&igrave; ch&uacute;ng ta sống tr&ecirc;n đời n&agrave;y kh&ocirc;ng phải để t&igrave;m thấy một người ho&agrave;n mỹ để y&ecirc;u m&agrave; ch&iacute;nh l&agrave; để học c&aacute;ch y&ecirc;u thương một người kh&ocirc;ng ho&agrave;n mỹ một c&aacute;ch trọn vẹn.<br />
          <br />
          Ch&igrave;a kh&oacute;a cho mối quan hệ d&agrave;i l&acirc;u kh&ocirc;ng phải ở việc t&igrave;m được đ&uacute;ng người để y&ecirc;u, m&agrave; l&agrave; học c&aacute;ch y&ecirc;u thương người m&agrave; ch&uacute;ng ta đ&atilde; chọn&rdquo;. C&oacute; lẽ v&igrave; em kh&ocirc;ng biết tr&acirc;n trọng anh n&ecirc;n &ocirc;ng trời đ&atilde; nỡ mang anh đi mất, rời xa em m&atilde;i m&atilde;i, bắt em phải sống trong những nỗi đau v&agrave; sự &acirc;n hận muộn m&agrave;ng. L&uacute;c anh c&ograve;n ở cạnh b&ecirc;n em đ&atilde; kh&ocirc;ng biết tr&acirc;n trọng, y&ecirc;u thương anh nhiều hơn, để khi anh đi rồi em mới biết mọi thứ đ&atilde; kh&ocirc;ng thể quay lại nữa rồi.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt="Mong manh như hương ai quen dịu dàng thoáng qua" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_10/Ngay_20/Images/mong-manh-tinh-ve-1.jpg" /></font></p>

          <p><br />
          <font face="Arial"><em>&ldquo;Bao nhi&ecirc;u cơn mơ em mơ chỉ để thấy anh<br />
          Bao nhi&ecirc;u m&ocirc;i h&ocirc;n dư &acirc;m ngọt ng&agrave;o vẫn đ&acirc;y&nbsp;<br />
          Mi&ecirc;n man tan trong v&ograve;ng tay một hạnh ph&uacute;c sao thật b&igrave;nh y&ecirc;n qu&aacute;&nbsp;<br />
          Nắng vẫn khẽ h&aacute;t &acirc;m &aacute;p đường chiều phố quen&nbsp;<br />
          Hương ai mong manh như sương giờ lại vấn vương&nbsp;<br />
          Run run đ&ocirc;i tim ng&acirc;n l&ecirc;n, ngập ngừng kh&uacute;c ca t&igrave;nh đắm say&rdquo;.</em><br />
          <br />
          Ng&agrave;y h&ocirc;m nay bước đi tr&ecirc;n con đường ngập tr&agrave;n sắc t&iacute;m, l&ograve;ng em đ&atilde; th&ocirc;i day dứt. Em biết ở tr&ecirc;n thi&ecirc;n đường anh sẽ lu&ocirc;n mong em được b&igrave;nh y&ecirc;n v&agrave; hạnh ph&uacute;c. V&igrave; anh y&ecirc;u em hơn ch&iacute;nh cả sinh mạng của m&igrave;nh. Nếu kh&ocirc;ng, người phải ra đi ng&agrave;y h&ocirc;m đ&oacute; l&agrave; em chứ kh&ocirc;ng phải anh. Em vẫn sẽ lu&ocirc;n y&ecirc;u anh, b&acirc;y giờ v&agrave; m&atilde;i m&atilde;i về sau cũng lu&ocirc;n như thế. V&agrave; em chỉ xin anh h&agrave;ng đ&ecirc;m h&atilde;y xuất hiện trong giấc mơ của em, để em c&oacute; thể tr&ograve; chuyện c&ugrave;ng anh, được &ocirc;m anh v&agrave; được nghe những kh&uacute;c h&aacute;t b&igrave;nh y&ecirc;n từ anh. Với em như thế l&agrave; hạnh ph&uacute;c.<br />
          <br />
          Em vẫn sẽ tiếp tục bước đi tr&ecirc;n con đường quen thuộc, vẫn gh&eacute; những qu&aacute;n c&agrave; ph&ecirc; ch&uacute;ng ta hay ngồi v&agrave; l&agrave;m những điều m&agrave; hai ta c&ograve;n dang dở chưa thực hiện được. V&agrave; đến một ng&agrave;y n&agrave;o đ&oacute; nếu em c&oacute; s&aacute;nh bước b&ecirc;n người con trai n&agrave;o kh&aacute;c th&igrave; xin anh cũng đừng buồn. Em chỉ l&agrave; muốn viết tiếp c&acirc;u chuyện t&igrave;nh y&ecirc;u của ch&uacute;ng ta, để n&oacute; c&oacute; một kết th&uacute;c thật đẹp như anh từng mong muốn. V&agrave; em sẽ chẳng bao giờ qu&ecirc;n anh. Em y&ecirc;u anh cả trong cơn mơ, giữa ngập tr&agrave;n những nỗi nhớ.<br />
          <br />
          <em>&ldquo;Tuổi thanh xu&acirc;n giống như một cơn mưa r&agrave;o, d&ugrave; cho bạn từng bị cảm lạnh v&igrave; tắm mưa, bạn vẫn muốn được đắm m&igrave;nh trong cơn mưa ấy một lần nữa&rdquo;.</em>&nbsp;V&agrave; em lu&ocirc;n muốn được đắm m&igrave;nh dưới những cơn mưa như thế. B&acirc;y giờ v&agrave; m&atilde;i m&atilde;i sau n&agrave;y, v&igrave; em biết dưới những cơn mưa đ&oacute; l&agrave; anh đang vỗ về, đang &ocirc;m lấy em&hellip;Em nhớ anh &ndash; ch&agrave;ng trai đến từ những cơn mưa.</font></p>
          ',
        status: :accepted,
        user_id: 11,
        category_id: 7,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/10.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      Post.create(
        post_type: :normal,
        title: "Bạn có thật sự hiểu về tương lai chưa?",
        description: "Đừng đếm những gì bạn đã mất, hãy quý trọng những gì bạn đang có và lên kế hoạch cho những gì sẽ đạt được bởi quá khứ không bao giờ trở lại, nhưng tương lai có thể bù đắp cho mất mát.",
        content: '<p><font face="Arial">1. Sự kh&aacute;c biệt giữa qu&aacute; khứ, hiện tại v&agrave; tương lai chỉ l&agrave; một ảo tưởng dai dẳng đến ngoan cố.</font><br />
          <br />
          <font face="Arial">(Albert Einstein)</font><br />
          <br />
          <font face="Arial">2. Tương lai của bạn phụ thuộc v&agrave;o rất nhiều điều, nhưng chủ yếu l&agrave; v&agrave;o bạn.</font><br />
          <br />
          <font face="Arial">(Frank Tyger)</font><br />
          <br />
          <font face="Arial">3. Lịch sử l&agrave; g&igrave;? Đ&oacute; l&agrave; tiếng vọng của qu&aacute; khứ trong tương lai v&agrave; l&agrave; &aacute;nh phản chiếu của tương lai tr&ecirc;n qu&aacute; khứ.</font><br />
          <br />
          <font face="Arial">(Victor Hugo)</font><br />
          <br />
          <font face="Arial">4. Đừng bao giờ để đến ng&agrave;y mai những việc m&agrave; bạn c&oacute; thể để đến ng&agrave;y kia.</font><br />
          <br />
          <font face="Arial">(Mark Twain)</font><br />
          <br />
          <font face="Arial">5. Qu&aacute; khứ l&agrave; tro t&agrave;n; tương lai l&agrave; gỗ. Chỉ ng&agrave;y h&ocirc;m nay l&agrave; lửa s&aacute;ng ch&oacute;i l&ograve;a.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt="Bạn có thật sự hiểu về tương lai chưa?" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_12/Ngay_1/Images/ban-co-that-su-hieu-ve-tuong-lai-chua.jpg" /></font></p>

          <p><br />
          <font face="Arial">(Ngạn ngữ Eskimo)</font><br />
          <br />
          <font face="Arial">6. Tương lai phụ thuộc v&agrave;o điều ch&uacute;ng ta l&agrave;m trong hiện tại.</font><br />
          <br />
          <font face="Arial">(Mahatma Gandhi)</font><br />
          <br />
          <font face="Arial">7. T&ocirc;i chẳng bao giờ nghĩ tới tương lai &ndash; n&oacute; lu&ocirc;n lu&ocirc;n đến đủ sớm.</font><br />
          <br />
          <font face="Arial">(Albert Einstein)</font><br />
          <br />
          <font face="Arial">8. Thế giới đầy những kẻ m&agrave; quan điểm về một tương lai thỏa m&atilde;n thực chất l&agrave; sự quay trở lại qu&aacute; khứ đầy l&yacute; tưởng.</font><br />
          <br />
          <font face="Arial">(Robertson Davies)</font><br />
          <br />
          <font face="Arial">9. Mối đe dọa lớn nhất hướng tới tương lai l&agrave; sự thờ ơ.</font><br />
          <br />
          <font face="Arial">(Khuyết danh)</font><br />
          <br />
          <font face="Arial">10. Đừng đếm những g&igrave; bạn đ&atilde; mất, h&atilde;y qu&yacute; trọng những g&igrave; bạn đang c&oacute; v&agrave; l&ecirc;n kế hoạch cho những g&igrave; sẽ đạt được bởi qu&aacute; khứ kh&ocirc;ng bao giờ trở lại, nhưng tương lai c&oacute; thể b&ugrave; đắp cho mất m&aacute;t.</font><br />
          <br />
          <font face="Arial">(Khuyết danh)</font><br />
          <br />
          <font face="Arial">11. Tương lai c&oacute; rất nhiều t&ecirc;n: Với kẻ yếu, n&oacute; l&agrave; Điều kh&ocirc;ng thể đạt được. Đối với người hay sợ h&atilde;i, n&oacute; l&agrave; Điều chưa biết. Với ai dũng cảm, n&oacute; l&agrave; Cơ hội.</font><br />
          <br />
          <font face="Arial">(Victor Hugo)</font><br />
          <br />
          <font face="Arial">12. T&ocirc;i chẳng c&oacute; g&igrave; để l&agrave;m với qu&aacute; khứ; với tương lai cũng vậy. T&ocirc;i sống trong hiện tại.</font><br />
          <br />
          <font face="Arial">(Ralph Waldo Emerson)</font><br />
          <br />
          <font face="Arial">13. Sống trong hiện tại thật kh&oacute; khăn, sống trong tương lai l&agrave; v&ocirc; nghĩa, v&agrave; sống trong qu&aacute; khứ l&agrave; bất khả thi.</font><br />
          <br />
          <font face="Arial">(Frank Herbert)</font><br />
          <br />
          <font face="Arial"><strong>Blog Radio Sưu tầm v&agrave; tổng hợp.</strong></font></p>

        ',
        status: :accepted,
        user_id: 12,
        category_id: 20,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/9.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      Post.create(
        post_type: :normal,
        title: "Bạn có thật sự hiểu về tương lai chưa?",
        description: "Đừng đếm những gì bạn đã mất, hãy quý trọng những gì bạn đang có và lên kế hoạch cho những gì sẽ đạt được bởi quá khứ không bao giờ trở lại, nhưng tương lai có thể bù đắp cho mất mát.",
        content: '<p><font face="Arial">1. Sự kh&aacute;c biệt giữa qu&aacute; khứ, hiện tại v&agrave; tương lai chỉ l&agrave; một ảo tưởng dai dẳng đến ngoan cố.</font><br />
          <br />
          <font face="Arial">(Albert Einstein)</font><br />
          <br />
          <font face="Arial">2. Tương lai của bạn phụ thuộc v&agrave;o rất nhiều điều, nhưng chủ yếu l&agrave; v&agrave;o bạn.</font><br />
          <br />
          <font face="Arial">(Frank Tyger)</font><br />
          <br />
          <font face="Arial">3. Lịch sử l&agrave; g&igrave;? Đ&oacute; l&agrave; tiếng vọng của qu&aacute; khứ trong tương lai v&agrave; l&agrave; &aacute;nh phản chiếu của tương lai tr&ecirc;n qu&aacute; khứ.</font><br />
          <br />
          <font face="Arial">(Victor Hugo)</font><br />
          <br />
          <font face="Arial">4. Đừng bao giờ để đến ng&agrave;y mai những việc m&agrave; bạn c&oacute; thể để đến ng&agrave;y kia.</font><br />
          <br />
          <font face="Arial">(Mark Twain)</font><br />
          <br />
          <font face="Arial">5. Qu&aacute; khứ l&agrave; tro t&agrave;n; tương lai l&agrave; gỗ. Chỉ ng&agrave;y h&ocirc;m nay l&agrave; lửa s&aacute;ng ch&oacute;i l&ograve;a.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt="Bạn có thật sự hiểu về tương lai chưa?" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_12/Ngay_1/Images/ban-co-that-su-hieu-ve-tuong-lai-chua.jpg" /></font></p>

          <p><br />
          <font face="Arial">(Ngạn ngữ Eskimo)</font><br />
          <br />
          <font face="Arial">6. Tương lai phụ thuộc v&agrave;o điều ch&uacute;ng ta l&agrave;m trong hiện tại.</font><br />
          <br />
          <font face="Arial">(Mahatma Gandhi)</font><br />
          <br />
          <font face="Arial">7. T&ocirc;i chẳng bao giờ nghĩ tới tương lai &ndash; n&oacute; lu&ocirc;n lu&ocirc;n đến đủ sớm.</font><br />
          <br />
          <font face="Arial">(Albert Einstein)</font><br />
          <br />
          <font face="Arial">8. Thế giới đầy những kẻ m&agrave; quan điểm về một tương lai thỏa m&atilde;n thực chất l&agrave; sự quay trở lại qu&aacute; khứ đầy l&yacute; tưởng.</font><br />
          <br />
          <font face="Arial">(Robertson Davies)</font><br />
          <br />
          <font face="Arial">9. Mối đe dọa lớn nhất hướng tới tương lai l&agrave; sự thờ ơ.</font><br />
          <br />
          <font face="Arial">(Khuyết danh)</font><br />
          <br />
          <font face="Arial">10. Đừng đếm những g&igrave; bạn đ&atilde; mất, h&atilde;y qu&yacute; trọng những g&igrave; bạn đang c&oacute; v&agrave; l&ecirc;n kế hoạch cho những g&igrave; sẽ đạt được bởi qu&aacute; khứ kh&ocirc;ng bao giờ trở lại, nhưng tương lai c&oacute; thể b&ugrave; đắp cho mất m&aacute;t.</font><br />
          <br />
          <font face="Arial">(Khuyết danh)</font><br />
          <br />
          <font face="Arial">11. Tương lai c&oacute; rất nhiều t&ecirc;n: Với kẻ yếu, n&oacute; l&agrave; Điều kh&ocirc;ng thể đạt được. Đối với người hay sợ h&atilde;i, n&oacute; l&agrave; Điều chưa biết. Với ai dũng cảm, n&oacute; l&agrave; Cơ hội.</font><br />
          <br />
          <font face="Arial">(Victor Hugo)</font><br />
          <br />
          <font face="Arial">12. T&ocirc;i chẳng c&oacute; g&igrave; để l&agrave;m với qu&aacute; khứ; với tương lai cũng vậy. T&ocirc;i sống trong hiện tại.</font><br />
          <br />
          <font face="Arial">(Ralph Waldo Emerson)</font><br />
          <br />
          <font face="Arial">13. Sống trong hiện tại thật kh&oacute; khăn, sống trong tương lai l&agrave; v&ocirc; nghĩa, v&agrave; sống trong qu&aacute; khứ l&agrave; bất khả thi.</font><br />
          <br />
          <font face="Arial">(Frank Herbert)</font><br />
          <br />
          <font face="Arial"><strong>Blog Radio Sưu tầm v&agrave; tổng hợp.</strong></font></p>

        ',
        status: :accepted,
        user_id: 12,
        category_id: 4,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/9.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )
      Post.create(
        post_type: :normal,
        title: "Nhà là nơi để về",
        description: "Đừng đếm những gì bạn đã mất, hãy quý trọng những gì bạn đang có và lên kế hoạch cho những gì sẽ đạt được bởi quá khứ không bao giờ trở lại, nhưng tương lai có thể bù đắp cho mất mát.",
        content: '<p><font face="Arial">1. Sự kh&aacute;c biệt giữa qu&aacute; khứ, hiện tại v&agrave; tương lai chỉ l&agrave; một ảo tưởng dai dẳng đến ngoan cố.</font><br />
          <br />
          <font face="Arial">(Albert Einstein)</font><br />
          <br />
          <font face="Arial">2. Tương lai của bạn phụ thuộc v&agrave;o rất nhiều điều, nhưng chủ yếu l&agrave; v&agrave;o bạn.</font><br />
          <br />
          <font face="Arial">(Frank Tyger)</font><br />
          <br />
          <font face="Arial">3. Lịch sử l&agrave; g&igrave;? Đ&oacute; l&agrave; tiếng vọng của qu&aacute; khứ trong tương lai v&agrave; l&agrave; &aacute;nh phản chiếu của tương lai tr&ecirc;n qu&aacute; khứ.</font><br />
          <br />
          <font face="Arial">(Victor Hugo)</font><br />
          <br />
          <font face="Arial">4. Đừng bao giờ để đến ng&agrave;y mai những việc m&agrave; bạn c&oacute; thể để đến ng&agrave;y kia.</font><br />
          <br />
          <font face="Arial">(Mark Twain)</font><br />
          <br />
          <font face="Arial">5. Qu&aacute; khứ l&agrave; tro t&agrave;n; tương lai l&agrave; gỗ. Chỉ ng&agrave;y h&ocirc;m nay l&agrave; lửa s&aacute;ng ch&oacute;i l&ograve;a.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt="Bạn có thật sự hiểu về tương lai chưa?" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_12/Ngay_1/Images/ban-co-that-su-hieu-ve-tuong-lai-chua.jpg" /></font></p>

          <p><br />
          <font face="Arial">(Ngạn ngữ Eskimo)</font><br />
          <br />
          <font face="Arial">6. Tương lai phụ thuộc v&agrave;o điều ch&uacute;ng ta l&agrave;m trong hiện tại.</font><br />
          <br />
          <font face="Arial">(Mahatma Gandhi)</font><br />
          <br />
          <font face="Arial">7. T&ocirc;i chẳng bao giờ nghĩ tới tương lai &ndash; n&oacute; lu&ocirc;n lu&ocirc;n đến đủ sớm.</font><br />
          <br />
          <font face="Arial">(Albert Einstein)</font><br />
          <br />
          <font face="Arial">8. Thế giới đầy những kẻ m&agrave; quan điểm về một tương lai thỏa m&atilde;n thực chất l&agrave; sự quay trở lại qu&aacute; khứ đầy l&yacute; tưởng.</font><br />
          <br />
          <font face="Arial">(Robertson Davies)</font><br />
          <br />
          <font face="Arial">9. Mối đe dọa lớn nhất hướng tới tương lai l&agrave; sự thờ ơ.</font><br />
          <br />
          <font face="Arial">(Khuyết danh)</font><br />
          <br />
          <font face="Arial">10. Đừng đếm những g&igrave; bạn đ&atilde; mất, h&atilde;y qu&yacute; trọng những g&igrave; bạn đang c&oacute; v&agrave; l&ecirc;n kế hoạch cho những g&igrave; sẽ đạt được bởi qu&aacute; khứ kh&ocirc;ng bao giờ trở lại, nhưng tương lai c&oacute; thể b&ugrave; đắp cho mất m&aacute;t.</font><br />
          <br />
          <font face="Arial">(Khuyết danh)</font><br />
          <br />
          <font face="Arial">11. Tương lai c&oacute; rất nhiều t&ecirc;n: Với kẻ yếu, n&oacute; l&agrave; Điều kh&ocirc;ng thể đạt được. Đối với người hay sợ h&atilde;i, n&oacute; l&agrave; Điều chưa biết. Với ai dũng cảm, n&oacute; l&agrave; Cơ hội.</font><br />
          <br />
          <font face="Arial">(Victor Hugo)</font><br />
          <br />
          <font face="Arial">12. T&ocirc;i chẳng c&oacute; g&igrave; để l&agrave;m với qu&aacute; khứ; với tương lai cũng vậy. T&ocirc;i sống trong hiện tại.</font><br />
          <br />
          <font face="Arial">(Ralph Waldo Emerson)</font><br />
          <br />
          <font face="Arial">13. Sống trong hiện tại thật kh&oacute; khăn, sống trong tương lai l&agrave; v&ocirc; nghĩa, v&agrave; sống trong qu&aacute; khứ l&agrave; bất khả thi.</font><br />
          <br />
          <font face="Arial">(Frank Herbert)</font><br />
          <br />
          <font face="Arial"><strong>Blog Radio Sưu tầm v&agrave; tổng hợp.</strong></font></p>

        ',
        status: :accepted,
        user_id: 11,
        category_id: 4,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/15.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )
      Post.create(
        post_type: :normal,
        title: "Những câu nói bất hủ của các vĩ nhân thế giới",
        description: "Đừng đếm những gì bạn đã mất, hãy quý trọng những gì bạn đang có và lên kế hoạch cho những gì sẽ đạt được bởi quá khứ không bao giờ trở lại, nhưng tương lai có thể bù đắp cho mất mát.",
        content: '<p><font face="Arial">1. Sự kh&aacute;c biệt giữa qu&aacute; khứ, hiện tại v&agrave; tương lai chỉ l&agrave; một ảo tưởng dai dẳng đến ngoan cố.</font><br />
          <br />
          <font face="Arial">(Albert Einstein)</font><br />
          <br />
          <font face="Arial">2. Tương lai của bạn phụ thuộc v&agrave;o rất nhiều điều, nhưng chủ yếu l&agrave; v&agrave;o bạn.</font><br />
          <br />
          <font face="Arial">(Frank Tyger)</font><br />
          <br />
          <font face="Arial">3. Lịch sử l&agrave; g&igrave;? Đ&oacute; l&agrave; tiếng vọng của qu&aacute; khứ trong tương lai v&agrave; l&agrave; &aacute;nh phản chiếu của tương lai tr&ecirc;n qu&aacute; khứ.</font><br />
          <br />
          <font face="Arial">(Victor Hugo)</font><br />
          <br />
          <font face="Arial">4. Đừng bao giờ để đến ng&agrave;y mai những việc m&agrave; bạn c&oacute; thể để đến ng&agrave;y kia.</font><br />
          <br />
          <font face="Arial">(Mark Twain)</font><br />
          <br />
          <font face="Arial">5. Qu&aacute; khứ l&agrave; tro t&agrave;n; tương lai l&agrave; gỗ. Chỉ ng&agrave;y h&ocirc;m nay l&agrave; lửa s&aacute;ng ch&oacute;i l&ograve;a.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt="Bạn có thật sự hiểu về tương lai chưa?" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_12/Ngay_1/Images/ban-co-that-su-hieu-ve-tuong-lai-chua.jpg" /></font></p>

          <p><br />
          <font face="Arial">(Ngạn ngữ Eskimo)</font><br />
          <br />
          <font face="Arial">6. Tương lai phụ thuộc v&agrave;o điều ch&uacute;ng ta l&agrave;m trong hiện tại.</font><br />
          <br />
          <font face="Arial">(Mahatma Gandhi)</font><br />
          <br />
          <font face="Arial">7. T&ocirc;i chẳng bao giờ nghĩ tới tương lai &ndash; n&oacute; lu&ocirc;n lu&ocirc;n đến đủ sớm.</font><br />
          <br />
          <font face="Arial">(Albert Einstein)</font><br />
          <br />
          <font face="Arial">8. Thế giới đầy những kẻ m&agrave; quan điểm về một tương lai thỏa m&atilde;n thực chất l&agrave; sự quay trở lại qu&aacute; khứ đầy l&yacute; tưởng.</font><br />
          <br />
          <font face="Arial">(Robertson Davies)</font><br />
          <br />
          <font face="Arial">9. Mối đe dọa lớn nhất hướng tới tương lai l&agrave; sự thờ ơ.</font><br />
          <br />
          <font face="Arial">(Khuyết danh)</font><br />
          <br />
          <font face="Arial">10. Đừng đếm những g&igrave; bạn đ&atilde; mất, h&atilde;y qu&yacute; trọng những g&igrave; bạn đang c&oacute; v&agrave; l&ecirc;n kế hoạch cho những g&igrave; sẽ đạt được bởi qu&aacute; khứ kh&ocirc;ng bao giờ trở lại, nhưng tương lai c&oacute; thể b&ugrave; đắp cho mất m&aacute;t.</font><br />
          <br />
          <font face="Arial">(Khuyết danh)</font><br />
          <br />
          <font face="Arial">11. Tương lai c&oacute; rất nhiều t&ecirc;n: Với kẻ yếu, n&oacute; l&agrave; Điều kh&ocirc;ng thể đạt được. Đối với người hay sợ h&atilde;i, n&oacute; l&agrave; Điều chưa biết. Với ai dũng cảm, n&oacute; l&agrave; Cơ hội.</font><br />
          <br />
          <font face="Arial">(Victor Hugo)</font><br />
          <br />
          <font face="Arial">12. T&ocirc;i chẳng c&oacute; g&igrave; để l&agrave;m với qu&aacute; khứ; với tương lai cũng vậy. T&ocirc;i sống trong hiện tại.</font><br />
          <br />
          <font face="Arial">(Ralph Waldo Emerson)</font><br />
          <br />
          <font face="Arial">13. Sống trong hiện tại thật kh&oacute; khăn, sống trong tương lai l&agrave; v&ocirc; nghĩa, v&agrave; sống trong qu&aacute; khứ l&agrave; bất khả thi.</font><br />
          <br />
          <font face="Arial">(Frank Herbert)</font><br />
          <br />
          <font face="Arial"><strong>Blog Radio Sưu tầm v&agrave; tổng hợp.</strong></font></p>

        ',
        status: :accepted,
        user_id: 12,
        category_id: 4,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/16.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      Post.create(
        post_type: :normal,
        title: "\"Độc thân không cô đơn\" - Đừng để cô đơn làm chật trái tim mình!",
        description: "Con gái mạnh mẽ, độc lập biết rằng cuộc sống không phải là những câu chuyện cổ tích để mơ mộng mà là những thử thách để vượt qua và trưởng thành hơn mỗi ngày dù đó có là các mối quan hệ bạn bè, tình cảm hay công việc đi chăng nữa. Thực tế là cách duy nhất để bạn có thể thực sự cảm thấy hạnh phúc.",
        content: '<p><font face="Arial"><strong>1. Tự tạo niềm vui cho m&igrave;nh</strong></font><br />
          <br />
          <font face="Arial">Điều tuyệt vời nhất của c&ocirc; g&aacute;i ch&iacute;nh l&agrave; cuộc sống n&agrave;y lu&ocirc;n vui vẻ v&agrave; tr&agrave;n ngập tiếng cười. Học c&aacute;ch để tự tạo niềm vui cho ch&iacute;nh m&igrave;nh, thỏa m&atilde;n những g&igrave; m&igrave;nh muốn v&agrave; bỏ qua hết những buồn phiền đi, đ&oacute; mới l&agrave; cuộc sống đ&iacute;ch thực đ&oacute;.</font><br />
          <br />
          <font face="Arial"><strong>2. H&atilde;y t&ocirc;n trọng ch&iacute;nh m&igrave;nh</strong></font><br />
          <br />
          <font face="Arial">Tr&ecirc;n tất cả, bạn phải tự y&ecirc;u qu&yacute; v&agrave; tr&acirc;n trọng ch&iacute;nh bản th&acirc;n m&igrave;nh. V&igrave; nếu bạn kh&ocirc;ng tr&acirc;n trọng m&igrave;nh th&igrave; chẳng ai c&oacute; thể l&agrave;m như vậy.</font><br />
          <br />
          <font face="Arial"><strong>3. Lu&ocirc;n giữ cho vẻ bề ngo&agrave;i c&acirc;n đối v&agrave; khỏe mạnh</strong></font><br />
          <br />
          <font face="Arial">Để trở th&agrave;nh một người con g&aacute;i mạnh mẽ, độc lập th&igrave; kh&ocirc;ng chỉ l&agrave; việc chăm lo về mặt tinh thần m&agrave; bạn c&ograve;n phải c&oacute; một vẻ ngo&agrave;i v&agrave; sức khỏe thực sự vững v&agrave;ng. H&atilde;y đến ph&ograve;ng tập gym, ăn những thực phẩm tốt cho sức khỏe v&agrave; bạn sẽ cảm thấy tự tin hơn mỗi ng&agrave;y.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt=" Hãy là con gái chứ không phải là bánh bèo vô dụng" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_10/Ngay_24/Images/hay-la-con-gai-chu-khong-phai-banh-beo-vo-dung1.jpg" /></font></p>

          <p><br />
          <font face="Arial"><strong>4. H&atilde;y l&agrave;m việc thật chăm chỉ</strong></font><br />
          <br />
          <font face="Arial">Con g&aacute;i mạnh mẽ, độc lập kh&ocirc;ng chỉ ngồi đ&oacute; v&agrave; chờ đợi. Họ l&agrave;m việc chăm chỉ để theo đuổi những giấc mơ v&agrave; đam m&ecirc; của bản th&acirc;n.</font><br />
          <br />
          <font face="Arial"><strong>5. Đừng bao giờ đứng y&ecirc;n</strong></font><br />
          <br />
          <font face="Arial">D&ugrave; cho đ&oacute; l&agrave; c&ocirc;ng việc hay cuộc sống của bạn, đừng bao giờ đứng y&ecirc;n v&agrave; chấp nhận những điều nhỏ b&eacute; hơn những g&igrave; m&agrave; bạn xứng đ&aacute;ng c&oacute; được. Nếu kh&ocirc;ng thực sự cảm thấy vui vẻ v&agrave; hạnh ph&uacute;c, h&atilde;y bước tiếp.</font><br />
          <br />
          <font face="Arial"><strong>6. H&atilde;y thực tế trong cuộc sống v&agrave; c&aacute;c mối quan hệ</strong></font><br />
          <br />
          <font face="Arial">Con g&aacute;i mạnh mẽ, độc lập biết rằng cuộc sống kh&ocirc;ng phải l&agrave; những c&acirc;u chuyện cổ t&iacute;ch để mơ mộng m&agrave; l&agrave; những thử th&aacute;ch để vượt qua v&agrave; trưởng th&agrave;nh hơn mỗi ng&agrave;y d&ugrave; đ&oacute; c&oacute; l&agrave; c&aacute;c mối quan hệ bạn b&egrave;, t&igrave;nh cảm hay c&ocirc;ng việc đi chăng nữa. Thực tế l&agrave; c&aacute;ch duy nhất để bạn c&oacute; thể thực sự cảm thấy hạnh ph&uacute;c.</font><br />
          <br />
          <font face="Arial"><strong>7. H&atilde;y tr&aacute;nh xa sự bốc đồng</strong></font><br />
          <br />
          <font face="Arial">Bất kỳ một c&ocirc; n&agrave;ng độc lập n&agrave;o cũng đều suy nghĩ thật kỹ trước khi h&agrave;nh động d&ugrave; đ&oacute; l&agrave; chuyện nhỏ hay thực sự lớn. V&igrave; họ tin rằng: cuộc sống l&agrave; kết tinh của tất cả những quyết định, v&igrave; thế đừng bốc đồng với bất kỳ một sự lựa chọn n&agrave;o.</font><br />
          <br />
          <font face="Arial"><strong>8. H&atilde;y lờ đi những người chỉ mang đến sự ti&ecirc;u cực</strong></font><br />
          <br />
          <font face="Arial">Những kẻ ti&ecirc;u cực c&oacute; mặt ở khắp mọi nơi: từ trường học, c&ocirc;ng sở đến cả tr&ecirc;n c&aacute;c trang mạng x&atilde; hội m&agrave; bạn tham gia. V&agrave; c&aacute;c c&ocirc; n&agrave;ng mạnh mẽ, độc lập lu&ocirc;n chọn c&aacute;ch phớt lờ v&agrave; kh&ocirc;ng để lời n&oacute;i, h&agrave;nh động v&agrave; cả nguồn năng lượng ti&ecirc;u cực của những người n&agrave;y ảnh hưởng đến m&igrave;nh.</font><br />
          <br />
          <font face="Arial"><strong>9. C&oacute; một cuộc sống ri&ecirc;ng cho bản th&acirc;n</strong></font><br />
          <br />
          <font face="Arial">Đừng d&agrave;nh tất cả thời gian của m&igrave;nh để loay hoay b&ecirc;n cạnh một ai đ&oacute; hay một điều g&igrave; đ&oacute;. V&igrave; ai cũng cần c&oacute; một cuộc sống ri&ecirc;ng, một kh&ocirc;ng gian ri&ecirc;ng d&agrave;nh cho m&igrave;nh để nghỉ ngơi v&agrave; t&igrave;m lại hơi thở sau chuỗi ng&agrave;y tất bật với c&ocirc;ng việc v&agrave; c&aacute;c mối quan hệ. H&atilde;y c&oacute; một cuộc sống ri&ecirc;ng cho bản th&acirc;n v&agrave; bạn sẽ trở n&ecirc;n thực sự độc lập.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt=" Hãy là con gái chứ không phải là bánh bèo vô dụng" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_10/Ngay_24/Images/hay-la-con-gai-chu-khong-phai-banh-beo-vo-dung2.jpg" /></font></p>

          <p><br />
          <font face="Arial"><strong>10. Tự giải quyết mọi vấn đề c&aacute; nh&acirc;n của m&igrave;nh</strong></font><br />
          <br />
          <font face="Arial">Tuy hỏi &yacute; kiến hay tham khảo lời khuy&ecirc;n của người kh&aacute;c th&igrave; vẫn lu&ocirc;n cần thiết nhưng h&atilde;y nhớ rằng n&uacute;t do bạn thắt lại th&igrave; chỉ c&oacute; m&igrave;nh bạn c&oacute; thể gỡ ra được. Đừng bao giờ biến người kh&aacute;c th&agrave;nh c&ocirc;ng cụ r&agrave; so&aacute;t v&agrave; sửa lỗi cho mọi vấn đề của cuộc đời bạn.</font><br />
          <br />
          <font face="Arial"><strong>11. B&igrave;nh tĩnh. Phải lu&ocirc;n giữ được sự b&igrave;nh tĩnh</strong></font><br />
          <br />
          <font face="Arial">Ph&aacute;t đi&ecirc;n v&agrave; c&aacute;u tiết với một chuyện sai tr&aacute;i n&agrave;o đ&oacute; quả thật rất dễ d&agrave;ng, dễ hơn việc giữ b&igrave;nh tĩnh rất nhiều. Nhưng những c&ocirc; n&agrave;ng mạnh mẽ, độc lập th&igrave; kh&ocirc;ng l&agrave;m như vậy v&igrave; họ c&oacute; thể giải quyết tất cả mọi t&igrave;nh huống khủng khiếp nhất với một tr&aacute;i tim b&igrave;nh thản nhất v&agrave; một t&acirc;m thế đĩnh đạc nhất.</font><br />
          <br />
          <font face="Arial"><strong>12. H&atilde;y tự đứng l&ecirc;n v&igrave; m&igrave;nh khi cần thiết</strong></font><br />
          <br />
          <font face="Arial">Những c&ocirc; n&agrave;ng mạnh mẽ, độc lập lu&ocirc;n biết đứng l&ecirc;n để tự bảo vệ cho quyền lợi v&agrave; hạnh ph&uacute;c của ch&iacute;nh bản th&acirc;n m&igrave;nh chứ kh&ocirc;ng chỉ biết tr&ocirc;ng chờ v&agrave;o số phận hay v&agrave;o sức mạnh của người kh&aacute;c.</font><br />
          <br />
          <font face="Arial"><strong>13. C&oacute; thể tự l&agrave;m mọi thứ nếu c&oacute; thể</strong></font><br />
          <br />
          <font face="Arial">Đ&acirc;y l&agrave; c&aacute;ch m&agrave; bạn độc lập theo đ&uacute;ng nghĩa đen của từ n&agrave;y. H&atilde;y tự t&igrave;m kiếm v&agrave; mang đến cho m&igrave;nh bất cứ thứ g&igrave; m&agrave; bạn cần, dẫu đ&oacute; c&oacute; l&agrave; tiền bạc, một ng&ocirc;i nh&agrave; hay thậm ch&iacute; l&agrave; hạnh ph&uacute;c. Điều n&agrave;y cũng gi&uacute;p bạn c&oacute; thể đỡ đần cho gia đ&igrave;nh v&agrave; người đ&agrave;n &ocirc;ng m&igrave;nh y&ecirc;u thương, chứng minh cho anh ấy biết rằng bạn y&ecirc;u kh&ocirc;ng phải v&igrave; tiền t&agrave;i, danh vọng m&agrave; y&ecirc;u ch&iacute;nh con người anh ấy.</font><br />
          <br />
          <font face="Arial"><strong>Blog Radio Tổng hợp.</strong></font></p>
          ',
        status: :accepted,
        user_id: 11,
        category_id: 18,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/18.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      Post.create(
        post_type: :normal,
        title: "Mở lòng và yêu đi, bởi vì ai cũng cần được yêu thương",
        description: "Con gái mạnh mẽ, độc lập biết rằng cuộc sống không phải là những câu chuyện cổ tích để mơ mộng mà là những thử thách để vượt qua và trưởng thành hơn mỗi ngày dù đó có là các mối quan hệ bạn bè, tình cảm hay công việc đi chăng nữa. Thực tế là cách duy nhất để bạn có thể thực sự cảm thấy hạnh phúc.",
        content: '<p><font face="Arial"><strong>1. Tự tạo niềm vui cho m&igrave;nh</strong></font><br />
          <br />
          <font face="Arial">Điều tuyệt vời nhất của c&ocirc; g&aacute;i ch&iacute;nh l&agrave; cuộc sống n&agrave;y lu&ocirc;n vui vẻ v&agrave; tr&agrave;n ngập tiếng cười. Học c&aacute;ch để tự tạo niềm vui cho ch&iacute;nh m&igrave;nh, thỏa m&atilde;n những g&igrave; m&igrave;nh muốn v&agrave; bỏ qua hết những buồn phiền đi, đ&oacute; mới l&agrave; cuộc sống đ&iacute;ch thực đ&oacute;.</font><br />
          <br />
          <font face="Arial"><strong>2. H&atilde;y t&ocirc;n trọng ch&iacute;nh m&igrave;nh</strong></font><br />
          <br />
          <font face="Arial">Tr&ecirc;n tất cả, bạn phải tự y&ecirc;u qu&yacute; v&agrave; tr&acirc;n trọng ch&iacute;nh bản th&acirc;n m&igrave;nh. V&igrave; nếu bạn kh&ocirc;ng tr&acirc;n trọng m&igrave;nh th&igrave; chẳng ai c&oacute; thể l&agrave;m như vậy.</font><br />
          <br />
          <font face="Arial"><strong>3. Lu&ocirc;n giữ cho vẻ bề ngo&agrave;i c&acirc;n đối v&agrave; khỏe mạnh</strong></font><br />
          <br />
          <font face="Arial">Để trở th&agrave;nh một người con g&aacute;i mạnh mẽ, độc lập th&igrave; kh&ocirc;ng chỉ l&agrave; việc chăm lo về mặt tinh thần m&agrave; bạn c&ograve;n phải c&oacute; một vẻ ngo&agrave;i v&agrave; sức khỏe thực sự vững v&agrave;ng. H&atilde;y đến ph&ograve;ng tập gym, ăn những thực phẩm tốt cho sức khỏe v&agrave; bạn sẽ cảm thấy tự tin hơn mỗi ng&agrave;y.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt=" Hãy là con gái chứ không phải là bánh bèo vô dụng" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_10/Ngay_24/Images/hay-la-con-gai-chu-khong-phai-banh-beo-vo-dung1.jpg" /></font></p>

          <p><br />
          <font face="Arial"><strong>4. H&atilde;y l&agrave;m việc thật chăm chỉ</strong></font><br />
          <br />
          <font face="Arial">Con g&aacute;i mạnh mẽ, độc lập kh&ocirc;ng chỉ ngồi đ&oacute; v&agrave; chờ đợi. Họ l&agrave;m việc chăm chỉ để theo đuổi những giấc mơ v&agrave; đam m&ecirc; của bản th&acirc;n.</font><br />
          <br />
          <font face="Arial"><strong>5. Đừng bao giờ đứng y&ecirc;n</strong></font><br />
          <br />
          <font face="Arial">D&ugrave; cho đ&oacute; l&agrave; c&ocirc;ng việc hay cuộc sống của bạn, đừng bao giờ đứng y&ecirc;n v&agrave; chấp nhận những điều nhỏ b&eacute; hơn những g&igrave; m&agrave; bạn xứng đ&aacute;ng c&oacute; được. Nếu kh&ocirc;ng thực sự cảm thấy vui vẻ v&agrave; hạnh ph&uacute;c, h&atilde;y bước tiếp.</font><br />
          <br />
          <font face="Arial"><strong>6. H&atilde;y thực tế trong cuộc sống v&agrave; c&aacute;c mối quan hệ</strong></font><br />
          <br />
          <font face="Arial">Con g&aacute;i mạnh mẽ, độc lập biết rằng cuộc sống kh&ocirc;ng phải l&agrave; những c&acirc;u chuyện cổ t&iacute;ch để mơ mộng m&agrave; l&agrave; những thử th&aacute;ch để vượt qua v&agrave; trưởng th&agrave;nh hơn mỗi ng&agrave;y d&ugrave; đ&oacute; c&oacute; l&agrave; c&aacute;c mối quan hệ bạn b&egrave;, t&igrave;nh cảm hay c&ocirc;ng việc đi chăng nữa. Thực tế l&agrave; c&aacute;ch duy nhất để bạn c&oacute; thể thực sự cảm thấy hạnh ph&uacute;c.</font><br />
          <br />
          <font face="Arial"><strong>7. H&atilde;y tr&aacute;nh xa sự bốc đồng</strong></font><br />
          <br />
          <font face="Arial">Bất kỳ một c&ocirc; n&agrave;ng độc lập n&agrave;o cũng đều suy nghĩ thật kỹ trước khi h&agrave;nh động d&ugrave; đ&oacute; l&agrave; chuyện nhỏ hay thực sự lớn. V&igrave; họ tin rằng: cuộc sống l&agrave; kết tinh của tất cả những quyết định, v&igrave; thế đừng bốc đồng với bất kỳ một sự lựa chọn n&agrave;o.</font><br />
          <br />
          <font face="Arial"><strong>8. H&atilde;y lờ đi những người chỉ mang đến sự ti&ecirc;u cực</strong></font><br />
          <br />
          <font face="Arial">Những kẻ ti&ecirc;u cực c&oacute; mặt ở khắp mọi nơi: từ trường học, c&ocirc;ng sở đến cả tr&ecirc;n c&aacute;c trang mạng x&atilde; hội m&agrave; bạn tham gia. V&agrave; c&aacute;c c&ocirc; n&agrave;ng mạnh mẽ, độc lập lu&ocirc;n chọn c&aacute;ch phớt lờ v&agrave; kh&ocirc;ng để lời n&oacute;i, h&agrave;nh động v&agrave; cả nguồn năng lượng ti&ecirc;u cực của những người n&agrave;y ảnh hưởng đến m&igrave;nh.</font><br />
          <br />
          <font face="Arial"><strong>9. C&oacute; một cuộc sống ri&ecirc;ng cho bản th&acirc;n</strong></font><br />
          <br />
          <font face="Arial">Đừng d&agrave;nh tất cả thời gian của m&igrave;nh để loay hoay b&ecirc;n cạnh một ai đ&oacute; hay một điều g&igrave; đ&oacute;. V&igrave; ai cũng cần c&oacute; một cuộc sống ri&ecirc;ng, một kh&ocirc;ng gian ri&ecirc;ng d&agrave;nh cho m&igrave;nh để nghỉ ngơi v&agrave; t&igrave;m lại hơi thở sau chuỗi ng&agrave;y tất bật với c&ocirc;ng việc v&agrave; c&aacute;c mối quan hệ. H&atilde;y c&oacute; một cuộc sống ri&ecirc;ng cho bản th&acirc;n v&agrave; bạn sẽ trở n&ecirc;n thực sự độc lập.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt=" Hãy là con gái chứ không phải là bánh bèo vô dụng" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_10/Ngay_24/Images/hay-la-con-gai-chu-khong-phai-banh-beo-vo-dung2.jpg" /></font></p>

          <p><br />
          <font face="Arial"><strong>10. Tự giải quyết mọi vấn đề c&aacute; nh&acirc;n của m&igrave;nh</strong></font><br />
          <br />
          <font face="Arial">Tuy hỏi &yacute; kiến hay tham khảo lời khuy&ecirc;n của người kh&aacute;c th&igrave; vẫn lu&ocirc;n cần thiết nhưng h&atilde;y nhớ rằng n&uacute;t do bạn thắt lại th&igrave; chỉ c&oacute; m&igrave;nh bạn c&oacute; thể gỡ ra được. Đừng bao giờ biến người kh&aacute;c th&agrave;nh c&ocirc;ng cụ r&agrave; so&aacute;t v&agrave; sửa lỗi cho mọi vấn đề của cuộc đời bạn.</font><br />
          <br />
          <font face="Arial"><strong>11. B&igrave;nh tĩnh. Phải lu&ocirc;n giữ được sự b&igrave;nh tĩnh</strong></font><br />
          <br />
          <font face="Arial">Ph&aacute;t đi&ecirc;n v&agrave; c&aacute;u tiết với một chuyện sai tr&aacute;i n&agrave;o đ&oacute; quả thật rất dễ d&agrave;ng, dễ hơn việc giữ b&igrave;nh tĩnh rất nhiều. Nhưng những c&ocirc; n&agrave;ng mạnh mẽ, độc lập th&igrave; kh&ocirc;ng l&agrave;m như vậy v&igrave; họ c&oacute; thể giải quyết tất cả mọi t&igrave;nh huống khủng khiếp nhất với một tr&aacute;i tim b&igrave;nh thản nhất v&agrave; một t&acirc;m thế đĩnh đạc nhất.</font><br />
          <br />
          <font face="Arial"><strong>12. H&atilde;y tự đứng l&ecirc;n v&igrave; m&igrave;nh khi cần thiết</strong></font><br />
          <br />
          <font face="Arial">Những c&ocirc; n&agrave;ng mạnh mẽ, độc lập lu&ocirc;n biết đứng l&ecirc;n để tự bảo vệ cho quyền lợi v&agrave; hạnh ph&uacute;c của ch&iacute;nh bản th&acirc;n m&igrave;nh chứ kh&ocirc;ng chỉ biết tr&ocirc;ng chờ v&agrave;o số phận hay v&agrave;o sức mạnh của người kh&aacute;c.</font><br />
          <br />
          <font face="Arial"><strong>13. C&oacute; thể tự l&agrave;m mọi thứ nếu c&oacute; thể</strong></font><br />
          <br />
          <font face="Arial">Đ&acirc;y l&agrave; c&aacute;ch m&agrave; bạn độc lập theo đ&uacute;ng nghĩa đen của từ n&agrave;y. H&atilde;y tự t&igrave;m kiếm v&agrave; mang đến cho m&igrave;nh bất cứ thứ g&igrave; m&agrave; bạn cần, dẫu đ&oacute; c&oacute; l&agrave; tiền bạc, một ng&ocirc;i nh&agrave; hay thậm ch&iacute; l&agrave; hạnh ph&uacute;c. Điều n&agrave;y cũng gi&uacute;p bạn c&oacute; thể đỡ đần cho gia đ&igrave;nh v&agrave; người đ&agrave;n &ocirc;ng m&igrave;nh y&ecirc;u thương, chứng minh cho anh ấy biết rằng bạn y&ecirc;u kh&ocirc;ng phải v&igrave; tiền t&agrave;i, danh vọng m&agrave; y&ecirc;u ch&iacute;nh con người anh ấy.</font><br />
          <br />
          <font face="Arial"><strong>Blog Radio Tổng hợp.</strong></font></p>
          ',
        status: :accepted,
        user_id: 13,
        category_id: 2,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/17.jpg")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      puts "Creating accepted posts - audio"

      Post.create(
        post_type: :audio,
        title: "Buông tay cũng là một cách để yêu thương",
        description: "Có những thứ dù bản thân ta có khao khát đến mấy, đã không thuộc về ta thì mãi mãi ta sẽ không sở hữu được nó. Tình cảm cũng vậy, rung động, yêu thương nhau một cách tự nhiên thì lúc mọi thứ trở nên nhạt nhòa, ta cũng hãy học cách để tình cảm ấy ra đi nhẹ nhàng. Buông tay một người đôi khi cũng là một cách để yêu thương, giải thoát cho bản thân khỏi sự cô đơn, khỏi sự vô tâm, hững hờ, cởi bỏ cho người những ràng buộc, gượng ép để tìm đến thế giới mới mà người cảm thấy hạnh phúc hơn.",
        content: '<p><strong><img src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_11/Ngay_8/Images/BuongTayCungLaMotCachDeYeuThuong.jpg" /></strong></p>
          ',
        status: :accepted,
        user_id: 12,
        category_id: 1,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/11.jpg")),
        audio: File.open(File.join(Rails.root, "app/assets/audio/1.mp3")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      Post.create(
        post_type: :audio,
        title: "Anh vẫn chưa là của ai nhưng cũng không thuộc về em",
        description: "Anh nói “Em buông tay đi, rồi em sẽ ổn, rồi sẽ có người thay thế anh yêu em và yêu em nhiều hơn anh từng yêu”. Em cũng hi vọng điều ấy lắm, nhưng thời gian càng trôi đi, em vẫn không thấy người ấy đâu anh. Em đã từ chối tất cả chỉ để dành thời gian nghĩ về anh và trớ trêu thay đấy chính là điều em đang làm để hạnh hạ bản thân. Anh vẫn chưa là của ai, nhưng anh vẫn không là của em. Em chỉ biết có thế nhưng không muốn chấp nhận thế.",
        content: '<p><font face="Arial">Tr&aacute;i tim em bất chợt rung động, bất chợt loạn nhịp trước &aacute;nh mắt v&agrave; nụ cười ấy một c&aacute;ch rất kh&ocirc;ng thể ngờ tới. Anh đến b&ecirc;n em như một định mệnh được sắp đặt sẵn m&agrave; đến cả em v&agrave; anh chưa bao giờ nghĩ đến.</font><br />
          <br />
          <font face="Arial">Khi con người ta y&ecirc;u, họ chỉ nh&igrave;n được cả thế giới qua người m&igrave;nh y&ecirc;u, họ chỉ nghĩ rằng tr&ecirc;n thế gian n&agrave;y chỉ c&oacute; họ v&agrave; người ấy để rồi ch&iacute;m đắm trong men t&igrave;nh v&agrave; thăng hoa trong hạnh ph&uacute;c. Họ qu&ecirc;n đi những x&aacute;o trộn ngo&agrave;i cuộc sống, qu&ecirc;n lu&ocirc;n những con người vẫn đang dần qua lại tr&ecirc;n phố, họ qu&ecirc;n tất cả để chỉ d&agrave;nh t&acirc;m tr&iacute; nhớ đến một người duy nhất đang b&ecirc;n cạnh họ.</font><br />
          <br />
          <font face="Arial">Y&ecirc;u! Em đ&atilde; y&ecirc;u anh bằng cả con tim rất ch&acirc;n thật. Để rồi anh rời xa em v&agrave; d&agrave;nh lại cho em một nỗi đau m&agrave; em chưa bao giờ phải nếm trải.</font><br />
          <br />
          <font face="Arial">Em c&oacute; qu&aacute; bảo thủ với x&atilde; hội kh&ocirc;ng, khi em n&oacute;i rằng em l&agrave; người sai v&agrave; em l&agrave; người đ&atilde; l&agrave;m mọi chuyện rối ren.</font><br />
          <br />
          <font face="Arial">Em c&oacute; qu&aacute; bảo thủ với x&atilde; hội kh&ocirc;ng, khi em tự nhận hết mọi đau khổ về m&igrave;nh m&agrave; kh&ocirc;ng chịu san sẻ cho anh, để rồi người ta nh&igrave;n v&agrave;o em bằng &aacute;nh mắt đầy-thương-hại.</font><br />
          <br />
          <font face="Arial">Đ&uacute;ng, em qu&aacute; bảo thủ m&agrave;!</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_11/Ngay_10/Images/anh-da-khong-con-la-cua-em.jpg" /></font></p>

          <p><br />
          <font face="Arial">Em bảo thủ đến nỗi hằng ng&agrave;y, hằng đ&ecirc;m tự nhốt m&igrave;nh lại trong c&aacute;i v&ograve;ng luẩn quẩn của y&ecirc;u v&agrave; kh&ocirc;ng y&ecirc;u rồi dằn vặt bản th&acirc;n. Anh c&oacute; thấy ai ngốc như em kh&ocirc;ng anh? Chỉ c&oacute; con ngốc mới y&ecirc;u theo c&aacute;ch ngốc nghếch như thế anh nhỉ?</font><br />
          <br />
          <font face="Arial">Khi b&ecirc;n anh, em thấy cả thế giới n&agrave;y đều mang một m&agrave;u hồng đẹp tinh kh&ocirc;i v&agrave; mỹ miều đến bao nhi&ecirc;u th&igrave; khi rời xa anh n&oacute; u &aacute;m, hoang lạnh đến bấy nhi&ecirc;u.</font><br />
          <br />
          <font face="Arial">Khi rời xa anh em mới biết được rằng t&igrave;nh cảm con người l&agrave; thứ kh&ocirc;ng thể điều khiển được.</font><br />
          <br />
          <font face="Arial">Em lu&ocirc;n tự m&igrave;nh dặn l&ograve;ng, cứ h&atilde;y sống vui vẻ v&agrave; thật hạnh ph&uacute;c đừng bao giờ buồn v&igrave; một người kh&ocirc;ng xứng đ&aacute;ng.</font><br />
          <br />
          <font face="Arial">Em lu&ocirc;n tự dặn m&igrave;nh rằng, trong thế giới hơn 7 tỷ người kia sẽ c&oacute; một người cần đến em v&agrave; y&ecirc;u thương em.</font><br />
          <br />
          <font face="Arial">Thế nhưng c&agrave;ng cố gắng qu&ecirc;n anh em lại c&agrave;ng nhớ anh nhiều hơn. Em đau, nỗi đau ấy cứ b&aacute;m theo theo. Anh vẫn chưa l&agrave; của ai, nhưng anh vẫn kh&ocirc;ng l&agrave; của em. Em chỉ biết c&oacute; thế nhưng kh&ocirc;ng muốn chấp nhận thế. Anh đ&atilde; v&ocirc; t&acirc;m bỏ lại em nơi n&agrave;y với những rối ren trong l&ograve;ng với cả một vết thương kh&oacute; l&agrave;nh đến vậy, anh n&agrave;o đ&acirc;u biết được răng em đang rất y&ecirc;u v&agrave; nhớ anh đến v&ocirc; c&ugrave;ng.</font><br />
          <br />
          <font face="Arial">Anh n&oacute;i &ldquo;Em bu&ocirc;ng tay đi, rồi em sẽ ổn, rồi sẽ c&oacute; người thay thế anh y&ecirc;u em v&agrave; y&ecirc;u em nhiều hơn anh từng y&ecirc;u&rdquo;. Em cũng hi vọng điều ấy lắm, nhưng thời gian c&agrave;ng tr&ocirc;i đi, em vẫn kh&ocirc;ng thấy người ấy đ&acirc;u anh. Em đ&atilde; từ chối tất cả chỉ để d&agrave;nh thời gian nghĩ về anh v&agrave; trớ tr&ecirc;u thay đấy ch&iacute;nh l&agrave; điều em đang l&agrave;m để hạnh hạ bản th&acirc;n.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_11/Ngay_10/Images/anh-da-khong-con-la-cua-em1.jpg" /></font></p>

          <p><br />
          <font face="Arial">Em l&agrave; c&ocirc; g&aacute;i anh từng biết rất mạnh mẽ, em hiểu điều đ&oacute;. Nhưng anh ch&iacute;nh l&agrave; người cướp đi tất cả, cướp đi cả sự mạnh mẽ c&ograve;n s&oacute;t lại trong em. Con g&aacute;i m&agrave; anh, d&ugrave; em c&oacute; mạnh mẽ đến nhường n&agrave;o đi chăng nữa đ&oacute; cũng chỉ l&agrave; vỏ bọc giả tạo em d&ugrave;ng để che mắt thi&ecirc;n hạ th&ocirc;i.</font><br />
          <br />
          <font face="Arial">Thực ra, nỗi đau n&agrave;o cũng sẽ qua, vết thương n&agrave;o rồi cũng sẽ l&agrave;nh, c&oacute; c&ograve;n th&igrave; cũng chỉ l&agrave; những vết sẹo, em tin n&oacute; cũng sẽ mờ dần theo năm th&aacute;ng. Anh cũng l&agrave; người ngang qua đời em, anh l&agrave; m&acirc;y l&agrave; gi&oacute; cũng kh&ocirc;ng d&agrave;nh cho em. Bởi m&acirc;y của trời để gi&oacute; cuốn đi. Nếu l&agrave; gi&oacute; th&igrave; chỉ l&agrave; thoảng qua b&ecirc;n tai rồi tạo cho ta cảm gi&aacute;c m&aacute;t lạnh khi ấy đ&ocirc;i ch&uacute;t chứ gi&oacute; bận cuốn m&acirc;y theo trời rồi. Nếu l&agrave; một cơn mưa, th&igrave; anh chỉ đến b&ecirc;n đời ta một c&aacute;ch bất chợt rồi cũng sẽ bất chợt đi th&ocirc;i, c&oacute; đời n&agrave;o mưa m&atilde;i được đ&acirc;u. H&atilde;y cứ vững t&acirc;m tin rằng &ldquo;sau cơn mưa trời sẽ s&aacute;ng&rdquo; chỉ c&oacute; thiếu &aacute;nh nắng mặt trời ch&uacute;ng ta mới chết chứ thiếu mưa đ&acirc;u c&oacute; sao nhỉ.</font><br />
          <br />
          <font face="Arial">Thế đấy, t&igrave;nh y&ecirc;u m&agrave;, khi y&ecirc;u ta cứ ch&aacute;y bỏng hết m&igrave;nh đi, nhưng khi n&oacute; qua rồi cứ để n&oacute; nhẹ nh&agrave;ng tr&ocirc;i qua m&agrave; đừng cố gắng v&ugrave;ng vẫy v&agrave;o vũng nước ấy chỉ khiến nước tung t&oacute;e ra th&ocirc;i v&agrave; người đau lại l&agrave; người cuối c&ugrave;ng ở lại&hellip;</font></p>
          ',
        status: :accepted,
        user_id: 11,
        category_id: 7,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/13.jpg")),
        audio: File.open(File.join(Rails.root, "app/assets/audio/1.mp3")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      Post.create(
        post_type: :audio,
        title: "Có một người trong đời gọi là Tri kỷ",
        description: "Có những thứ dù bản thân ta có khao khát đến mấy, đã không thuộc về ta thì mãi mãi ta sẽ không sở hữu được nó. Tình cảm cũng vậy, rung động, yêu thương nhau một cách tự nhiên thì lúc mọi thứ trở nên nhạt nhòa, ta cũng hãy học cách để tình cảm ấy ra đi nhẹ nhàng. Buông tay một người đôi khi cũng là một cách để yêu thương, giải thoát cho bản thân khỏi sự cô đơn, khỏi sự vô tâm, hững hờ, cởi bỏ cho người những ràng buộc, gượng ép để tìm đến thế giới mới mà người cảm thấy hạnh phúc hơn.",
        content: '<p><font face="Arial">Cơn mưa bất chợt gột sạch bầu kh&ocirc;ng kh&iacute; ngột ngạt kh&oacute; thở vẫn c&ograve;n vương vấn của m&ugrave;a hạ nắng gắt. Cơn mưa mang theo hơi đất ng&agrave;o ngạt m&ugrave;i ngai ng&aacute;i của mưa, mang theo hương vị caf&eacute; phảng phất quanh đ&acirc;y. K&yacute; ức về anh lại &ugrave;a về. Em nhớ anh, nhớ anh cồn c&agrave;o&hellip;<br />
          <br />
          <em>H&ocirc;m nay em muốn kể anh nghe c&acirc;u chuyện t&igrave;nh của một người thứ ba&hellip;</em><br />
          <br />
          Th&aacute;ng 10 về rồi anh ạ. Em xa anh cũng v&agrave;o một ng&agrave;y th&aacute;ng 10. Cũng hơn một năm c&oacute; lẻ. C&oacute; chăng anh vẫn c&ograve;n nhớ tới em? Nhưng tất cả những g&igrave; thuộc về anh, tr&aacute;i tim em chưa bao giờ qu&ecirc;n v&agrave; cũng kh&ocirc;ng muốn qu&ecirc;n v&igrave; đ&oacute; l&agrave; những điều tuyệt nhất m&agrave; định mệnh đ&atilde; mang lại cho em.<br />
          <br />
          Em quen anh v&agrave;o một ng&agrave;y nắng bỏng r&aacute;t v&agrave; xa anh v&agrave;o một ng&agrave;y thu th&aacute;ng 10 nhẹ nh&agrave;ng. &Aacute;nh nắng le lắt qua từng kẽ l&aacute; chiếu rọi con đường anh đưa em đi. Từng ng&agrave;y qua đi, em được n&oacute;i chuyện với anh nhiều hơn v&agrave; cũng hiểu anh nhiều hơn so với những g&igrave; mọi người xung quanh n&oacute;i. Quen anh, em bắt đầu được biết nhiều điều hơn. V&agrave; từ từ, em bắt đầu thần tượng anh. Người ta thường bảo con g&aacute;i hay ngưỡng mộ những người c&oacute; t&agrave;i. Trong l&ograve;ng em l&uacute;c đấy, anh c&oacute; lẽ sẽ chỉ xuất hiện trong truyện ng&ocirc;n t&igrave;nh với h&igrave;nh ảnh so&aacute;i ca. Dần d&agrave; em n&oacute;i chuyện với anh nhiều hơn. Anh động vi&ecirc;n, chia sẻ với em những điều em cần l&agrave;m.</font><br />
          &nbsp;</p>

          <p><font face="Arial"><img alt="Yêu anh nhưng chỉ mình em biết" src="http://media3.nhacvietplus.com.vn/Upload/CMS/Nam_2016/Thang_11/Ngay_10/Images/yeu-anh-chi-minh-em-biet.jpg" /></font></p>

          <p><br />
          <font face="Arial">Những l&uacute;c đi l&agrave;m việc c&ugrave;ng anh, anh chăm s&oacute;c em như một người em g&aacute;i, tận t&igrave;nh v&agrave; đầy y&ecirc;u thương. V&agrave; em cũng kh&ocirc;ng biết, t&igrave;nh cảm của em d&agrave;nh cho anh lớn l&ecirc;n từng ng&agrave;y như thế n&agrave;o. Em chỉ biết một ng&agrave;y kh&ocirc;ng được nh&igrave;n thấy anh, kh&ocirc;ng được nghe giọng n&oacute;i của anh, em cảm thấy ngột ngạt. Người ta thường n&oacute;i: &ldquo;Lửa gần rơm l&acirc;u ng&agrave;y cũng b&eacute;n&rdquo;. C&oacute; lẽ đ&uacute;ng thật! Em lu&ocirc;n tự nhắc m&igrave;nh rằng em chi đơn giản l&agrave; qu&yacute; mến anh, vậy th&ocirc;i. T&igrave;nh cảm đ&acirc;u c&oacute; phải m&igrave;nh kh&ocirc;ng muốn l&agrave; được đ&acirc;u anh, em bỗng chợt nhận ra em y&ecirc;u anh từ l&uacute;c n&agrave;o em cũng kh&ocirc;ng biết nữa. Mỗi lần thấy anh, tr&aacute;i tim em lại nghẹn lại.<br />
          <br />
          <em>Y&ecirc;u anh nhưng lại phải tỏ ra m&igrave;nh chỉ quan t&acirc;m anh như một người em g&aacute;i đối với một người anh trai. C&oacute; lẽ anh cũng kh&ocirc;ng biết n&ecirc;n cứ đối xử với em v&ocirc; tư như vậy, chiều l&ograve;ng em trước những giận hờn v&ocirc; cớ.<br />
          <br />
          Y&ecirc;u anh m&agrave; cứ phải k&igrave;m n&eacute;n nỗi buồn khi anh nhắc tới người anh y&ecirc;u thương.<br />
          <br />
          Y&ecirc;u anh m&agrave; cứ phải &acirc;m thầm hạnh ph&uacute;c khi được anh quan t&acirc;m, chiều chuộng.<br />
          <br />
          Y&ecirc;u anh m&agrave; cứ x&oacute;t xa khi anh chỉ coi em như người em g&aacute;i.</em><br />
          <br />
          L&ograve;ng tự dặn m&igrave;nh phải độc lập th&ocirc;i, v&igrave; em biết sẽ chẳng thể được ở b&ecirc;n anh l&acirc;u nhưng em nhận ra em cần anh, d&ugrave; chỉ l&agrave; sự quan t&acirc;m nhỏ nhặt, d&ugrave; chỉ l&agrave; c&aacute;i xoa đầu khi em nũng nịu với anh, d&ugrave; chỉ l&agrave; những lời khuy&ecirc;n của anh khi em gặp rắc rối&hellip;<br />
          <br />
          V<em>&agrave; b&acirc;y giờ&hellip;<br />
          <br />
          Đ&atilde; bao l&acirc;u ch&uacute;ng ta kh&ocirc;ng c&ograve;n tr&ograve; chuyện với nhau&hellip;<br />
          <br />
          Đ&atilde; bao l&acirc;u em kh&ocirc;ng c&ograve;n được nghe thấy giọng n&oacute;i nhẹ nh&agrave;ng của anh&hellip;<br />
          <br />
          Đ&atilde; bao l&acirc;u em đ&atilde; kh&ocirc;ng c&ograve;n được nh&igrave;n thấy b&oacute;ng h&igrave;nh anh in dấu tr&ecirc;n con đường đi về&hellip;</em><br />
          <br />
          C&oacute; lẽ anh sẽ kh&ocirc;ng bao giờ biết đ&atilde; v&agrave; đang c&oacute; một người nhớ anh từng ng&agrave;y, từng giờ. Mỗi gi&acirc;y ph&uacute;t tr&ocirc;i qua em mong, mong sao c&oacute; thể bất chợt được nh&igrave;n thấy anh tr&ecirc;n con đường em đang bước đi một m&igrave;nh. D&ugrave; rằng kh&ocirc;ng thể nghe thấy giọng n&oacute;i ấm &aacute;p của anh, chỉ cần l&agrave; thấy được b&oacute;ng h&igrave;nh anh&hellip; Ước mơ nhỏ nhoi ấy sao lại lớn lao đến thế. V&igrave; sao t&igrave;nh y&ecirc;u ấy cứ lớn l&ecirc;n m&agrave; kh&ocirc;ng thể dừng lại? L&agrave; kh&ocirc;ng thể dừng lại hay bản th&acirc;n em vẫn muốn giữ lại một ch&uacute;t g&igrave; đẹp nhất cho tuổi thanh xu&acirc;n đang qua đi của m&igrave;nh?<br />
          <br />
          Em lu&ocirc;n nhớ anh v&agrave; sẽ m&atilde;i nhớ anh...</font></p>
          ',
        status: :accepted,
        user_id: 11,
        category_id: 8,
        image: File.open(File.join(Rails.root, "app/assets/images/posts/12.jpg")),
        audio: File.open(File.join(Rails.root, "app/assets/audio/1.mp3")),
        created_at: (Time.now - rand(Time.now.month).month)
      )

      puts "Creating pending posts"
      9.times do |n|
        Post.create(
          post_type: :normal,
          title: Faker::Hipster.sentence,
          description: Faker::Hipster.sentence,
          content: Faker::Hipster.paragraph,
          status: :pending,
          category_id: Category.order("rand()").first.id,
          image: File.open(File.join(Rails.root, "app/assets/images/posts/2.jpg")),
          user_id: 1,
          created_at: (Time.now - rand(Time.now.month).month)
        )
      end

      puts "Creating confessions"
      9.times do
        Confession.create(
          content: Faker::Hipster.paragraph,
          created_at: (Time.now - rand(Time.now.month).month),
          status: :accepted
        )
      end

      puts "Creating peding confessions"
      9.times do
        Confession.create content: Faker::Hipster.paragraph, status: :pending
      end

      puts "Creating post like"
      (1..15).each do |post_id|
        rand(10).times do |like|
          Post.find(post_id).likes.create user_id: rand(14)
        end
      end

    else
      puts "Can rake db:remake in development & staging environments only"
    end
  end
end
