import QtQuick 2.13
import QtQuick.Controls 2.5

ImageGeneratorPage {
    objectName: "WalksPage"
    id: walksPageId

    function drawRequested() {
        imageSource = "http://localhost:60564/get/?walk/id123/144/144/true/0"
    }
}
