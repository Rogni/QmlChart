import QtQuick 2.11
import QtQuick.Controls 2.11
import QtCharts 2.3

Item {
    id: root

    enum AxisType {
        XAxis,
        YAxis
    }
    property int axisType: ChartGrid.AxisType.XAxis
    property ValueAxis axis
    property color color: "lightgray"
    property int gridWidth: 2
    property double tickInterval: 1

    function styledValue(value) {
        return Math.round(value*100)/100
    }

    onTickIntervalChanged: {
        // if tick interval equals 0 then in Repeater model expected zero division error
        // tick interval < 0 not valid
        if (tickInterval <= 0) {
            console.error("Tick interval must be > 0")
            tickInterval = 1
        }
    }

    anchors.fill: parent
    z: parent.z - 1

    Repeater {
        Rectangle {
            anchors {
                // used x axis
                top: axisType == ChartGrid.XAxis ? parent.top : undefined
                bottom: axisType == ChartGrid.XAxis ? parent.bottom : undefined
                // used y axis
                left: axisType == ChartGrid.YAxis ? parent.left : undefined
                right: axisType == ChartGrid.YAxis ? parent.right : undefined
            }
            color: root.color
            property var value: Math.round(root.axis.min) + index*root.tickInterval
                                + root.parent.width*0 + root.parent.height*0 // bind to ChartView width and height changed
            property point position: root.parent.mapToPosition(Qt.point(value , value))

            // ignored if used y axis
            width: root.gridWidth
            x: position.x

            // ignored if used x axis
            height: root.gridWidth
            y: position.y

            Label {
                anchors {
                    margins: 2
                    left: axisType == ChartGrid.XAxis ? parent.right : parent.left
                    bottom: axisType == ChartGrid.XAxis ? parent.bottom : undefined
                    top: axisType == ChartGrid.YAxis ? parent.top : undefined
                }
                text: root.styledValue(value)
            }
        }

        model: (root.axis.max - root.axis.min)/root.tickInterval + 1
    }

}
