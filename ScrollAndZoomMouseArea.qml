import QtQuick 2.9
import QtQuick.Window 2.2
import QtCharts 2.3
import QtQuick.Controls 2.4

MouseArea {
    id: chartMouseArea
    anchors.fill: parent

    property point lastMousePosition
    
    onPressed: {
        lastMousePosition.x = mouseX
        lastMousePosition.y = mouseY
    }
    onReleased: {
        lastMousePosition.x = -1
        lastMousePosition.y = -1
    }
    
    onMouseXChanged: {
        if (!pressed) return;
        var dx = lastMousePosition.x - mouseX
        parent.scrollRight(dx)
        lastMousePosition.x = mouseX
    }
    
    onMouseYChanged: {
        if (!pressed) return;
        var dy = lastMousePosition.y - mouseY
        parent.scrollDown(dy)
        lastMousePosition.y = mouseY
    }
    
    onWheel: {
        if (wheel.angleDelta.y > 0) {
            parent.zoomIn()
        } else {
            parent.zoomOut()
        }
    }
}
