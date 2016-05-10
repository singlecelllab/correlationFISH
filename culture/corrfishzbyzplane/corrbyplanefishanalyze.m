function [sumobjects,BiImstackhyb1a647,BiImstackhyb2a647,newtissueimage]=corrbyplanefishanalyze(Imstackhyb1a647,Imstackhyb2a647,zplanerange)


            sizeimfish1=size(Imstackhyb1a647);
            sizeimfish2=size(Imstackhyb2a647);
 
            rangei=sizeimfish1(3);
            rangej=sizeimfish2(3);  
            
           
            G = fspecial('gaussian',[30 30],15);
 
    
       
            for p=1:rangei
                
                 imbck = imfilter(Imstackhyb1a647(:,:,p),G,'same');
                 imgdeb=Imstackhyb1a647(:,:,p)-(imbck);

               intsumplane(p)=sum(sum(imgdeb));
               
              clear imgdeb;

            end
            
             maxintplaneim1=find(intsumplane==(max(intsumplane)));
            
             indmaxintplaneim1= ind2sub(rangei,maxintplaneim1);
             


            for m=1:rangej
                
                 imbckclean = imfilter(Imstackhyb2a647(:,:,m),G,'same');
                 imgdebclean=Imstackhyb2a647(:,:,m)-(imbckclean);

               x_correlation = xcorr2(imcrop(Imstackhyb1a647(:,:,indmaxintplaneim1),[350 350 300 300]),imcrop(imgdebclean,[350 350 300 300]));
             corrdepth(m)=max(max(x_correlation));
%                Imstackhyb2a647(:,:,m)=imlargerem(Imstackhyb2a647(:,:,m),10000);
            clear imgdebclean;

            end
            maxintplaneim2=find(corrdepth==(max(corrdepth)));
            indmaxintplaneim2= ind2sub(rangej,maxintplaneim2);       
           
            
            for tt=1:zplanerange

            
            Imstackhyb1a647=uint32(Imstackhyb1a647);
            Imstackhyb2a647=uint32(Imstackhyb2a647);
            

  

            BiImstackhyb1a647(:,:,tt)= imadd(Imstackhyb1a647(:,:,indmaxintplaneim1+tt-2),Imstackhyb1a647(:,:,indmaxintplaneim1+tt-1));
            BiImstackhyb2a647(:,:,tt)= imadd(Imstackhyb2a647(:,:,indmaxintplaneim2+tt-2),Imstackhyb2a647(:,:,indmaxintplaneim2+tt-1));
                      
            wind=20;
            
            newtissueimage(:,:,tt)=corrfishsubcellcountculture(double(BiImstackhyb1a647(:,:,tt)),double(BiImstackhyb2a647(:,:,tt)),wind,wind);
            objectcounts(tt)=sum(sum(newtissueimage(:,:,tt)));
            
           
                   
            end
                        
            sumobjects= sum(objectcounts);
            warning off;
                    
end

