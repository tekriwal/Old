s=1;
while(1)
    figure(1);
    clf;
    plot(lfp([annot(s,1):annot(s,2)]+1,1));
    hold on;
    plot(lfp([annot(s,1):annot(s,2)]+1,2)-0.02,'k');
    plot(lfp([annot(s,1):annot(s,2)]+1,3)-0.04,'r');
    plot(emg([annot(s,1):annot(s,2)]+1,1)-0.08,'g');
    plot(emg([annot(s,1):annot(s,2)]+1,2)-0.12,'g');
    
    ttl=sprintf('%d-%d, State(%d):%d', annot(s,1)+1, annot(s,2)+1, annot(s,4), annot(s,3));
    title(ttl);
    legend('LFP01','LFP12','LFP23');
    
    reply = input('Next(6), Previous(4):','s');
        
    if isempty(reply)
          reply = '6';
    end
    if reply=='4'
        if s>1
        s=s-1;
        end
    elseif reply=='6'
        s=s+1;
    end
end