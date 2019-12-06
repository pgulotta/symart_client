import QtQuick 2.13
import QtQuick.Controls 2.5

Page {
    id: infoPageId
    objectName: "InfoPage"
    property string pageTitle
    title: pageTitle

    Image {
        id: img
        //   height: 400
        //    width: 400
        //source: "file://home/pat/Downloads/aa.png"
        source: "qrc:/view/images/orbit-traps.png"
    }
    //https://en.wikipedia.org/wiki/Alpha_compositing//  https://www.flickr.com/photos/rogerellisplacephoto/49142507231
    //  QQuickImageProvider
}
