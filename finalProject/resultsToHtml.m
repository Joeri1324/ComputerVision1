function resultsToHtml(predictions, testY, fileNames, back)
    disp("<tbody>")
    
    for ii = 1:size(predictions, 1)
        html = "<tr>";
        
        for jj = 1:size(predictions, 2)
            prediction = predictions(ii, jj);
            classFileIndex = back(prediction, :);
            fileName = fileNames{classFileIndex(1)}(1, classFileIndex(2));
            htmlline = strcat("<td><img src='", fileName);
            htmlline = strcat(htmlline, "' /></td>");
            html = strcat(html, htmlline);
            %strcat(html, 
        end
        html = strcat(html, "</tr>");
        
        disp(html);
    end
    
    disp("</tbody>")
end