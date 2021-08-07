function [ output ] = ImageResizeCell( data,options )
%  data -- cellÊý¾Ý

[Row,Col] = size(data{1,1});
[nRow,nCol] = size(data);

ReRow = Row/(2^options.TranTime);
ReCol = Col/(2^options.TranTime);

output = cell(nRow,nCol);
for i1=1:nRow
    for i2=1:nCol
        Matrix = data{i1,i2};
        output{i1,i2} = imresize( Matrix,[ReRow,ReCol]);
    end
end

end

