function output = convert(input)
n=length(input);
output=zeros(n,1);
for k=1:n
    output(k)=str2double(input(k));
end
 