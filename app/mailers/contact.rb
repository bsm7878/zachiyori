class Contact < ApplicationMailer
    
    def welcome flyer, content #고객 => 자취요리연구소
        email = mail from: flyer, 
                to: 'contact@zachiyori.com', 
                subject: '자취요리연구소',
                body: content
    end
    
        
    def order mart_email, title, name, menu, menu_ingredient, option, address, public_pw, want_content, phone, p1, p2, p3 #주문들어오면 알려주기
        email = mail from: 'bsm7878@naver.com', 
                to: mart_email, 
                subject: title,
                body: name + "\n" + menu + "\n" + menu_ingredient + "\n" + option + "\n" + address + "\n" + public_pw + "\n" + want_content + "\n" + phone + "\n" + "\n" + p1 + "\n" + p2 + "\n" + p3
    end
    
end
