t = 10 * rand(1, 10);
c = 10 * rand(1, 10);

e = [t c];
e = sort(e);

q = zeros(size(e));
status = "IDLE";

for i = 1:length(e)
    if(i==1)
        status = "BUSY";
    else
        q(i) = q(i-1);
        if(ismember(e(i),c))
            if(q(i) ~= 0)
                q(i) = q(i) - 1;
            else
                status = "IDLE";
            end
        end
        if(ismember(e(i),t))
            if(status=="BUSY")
                q(i) = q(i) + 1;
            else
                status = "BUSY";
            end
        end
    end
end

qlt = zeros(1,max(q)+1);

for i = 1:length(e)-1
    if(i==1)
        qlt(q(i)+1) = e(i);
    end
    qlt(q(i)+1) = qlt(q(i)+1) + e(i+1) - e(i);
end

qlt_sum = 0;
for i = 1:length(qlt)
    qlt_sum = qlt_sum + (i-1) * qlt(i);
end

qlt_average = qlt_sum / e(length(e));
disp(qlt_average);

% Plotting
figure;
bar(e, q);
xlabel('Time');
ylabel('Queue Length');
title('Queue Length Over Time');
