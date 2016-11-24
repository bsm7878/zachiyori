class Contact < ApplicationMailer
    
    def welcome flyer, content #고객 => 자취요리연구소
        email = mail from: flyer, 
                to: 'contact@zachiyori.com', 
                subject: '자취요리연구소',
                body: content
    end
    
        
    def order mart_email, title, content #주문들어오면 알려주기
        email = mail from: 'bsm7878@naver.com', 
                to: mart_email, 
                subject: title,
                body: content
    end
    
end
