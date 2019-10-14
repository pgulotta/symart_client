import QtQuick 2.13
import QtQuick.Controls 2.5

ImageGeneratorPage {
    objectName: "LinesPage"
    id: linesPageId

    function drawRequested() {
        imageSource = "https://localhost:60564/test/?lines"
    }
}
