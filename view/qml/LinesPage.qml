import QtQuick 2.13
import QtQuick.Controls 2.5

ImageGeneratorPage {
    objectName: "LinesPage"
    id: linesPageId

    function drawImage() {
        imageSource = "https://localhost:60564/test/?lines"
    }
}
