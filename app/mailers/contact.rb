class Contact < ApplicationMailer
    
    def welcome flyer, content #고객 => 자취요리연구소
        email = mail from: flyer, 
                to: 'contact@zachiyori.com', 
                subject: '자취요리연구소',
                body: content
    end
    
        
    
    def order mart_email, title, name, menu, menu_ingredient, option, address, public_pw, want_content, phone, p1, p2, p3 #주문들어오면 알려주기
        add = URI.encode(address)
        naver = "https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&oquery=네이버지도&ie=utf8&query=#{add}"
        RestClient.post "https://api:key-58cb05535db9e0e2095709e152b00c77"\
        "@api.mailgun.net/v3/sandbox46f0226b110045b4a455d9119d83c8e0.mailgun.org/messages",
        :from => "bsm7878@naver.com",
        :to => mart_email,
        :cc => 'contact@zachiyori.com',
        :subject => title,
        :html => name + "<br>" + menu + "<br>" + menu_ingredient + "<br>" + option + "<br>" + "주소:" + "<a href = #{naver}>#{address}</a>" + "<br>" + public_pw + "<br>" + want_content + "<br>" + "<a href=tel:#{phone}><u>전화걸기</u></a>" + "<br>" + "<br>" + p1 + "<br>" + p2 + "<br>" + p3
    end
    
    
    
end
