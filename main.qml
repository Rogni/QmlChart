import QtQuick 2.12
import QtQuick.Controls 2.12
import QtCharts 2.3

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")
    header: ToolBar { Switch { id: switchButton } }

    ChartView {
        id: chartView
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: rect.left
            left: parent.left
        }
        ScrollAndZoomMouseArea {}
        backgroundColor: "transparent"
        legend.visible: false
        plotArea: Qt.rect(0,0,width,height)

        ValueAxis {
            id: xValueAxis;
            min: 0
            max: 4
            titleVisible: false
            gridVisible: false
        }
        ValueAxis {
            id: yValueAxis
            min: 0
            max: 4
            titleVisible: false
            gridVisible: false
        }

        LineSeries {
            id: plot
            axisX: xValueAxis; axisY: yValueAxis
            Component.onCompleted: {
                var from = 0
                var to= 10

                for (var i = from; i < to; i+=1) {
                    append(i, Math.random())
                }
            }
        }

        ChartGrid {
            axis: xValueAxis
            axisType: ChartGrid.XAxis
            tickInterval: 1
            color: "lightgreen"
            function styledValue(value) {
                return "%1 abs value".arg(value)
            }
        }

        ChartGrid {
            axis: yValueAxis
            axisType: ChartGrid.YAxis
            tickInterval: 0.5
        }

    }

    Rectangle {
        id: rect
        color: "green"
        anchors {
            top: parent.top
            bottom: parent.bottom
            right: parent.right
        }
        width: switchButton.checked ? 300 : 0
    }
}
