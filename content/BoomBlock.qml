import QtQuick 1.0
import Qt.labs.particles 1.0

Item {
    id: block

    property int type: 0
    property bool dying: false

    property bool spawned: false

    Behavior on x {
        enabled: spawned;
        SpringAnimation{ spring: 2; damping: 0.2 }
    }
    Behavior on y {
        SpringAnimation{ spring: 2; damping: 0.2 }
    }

    Image {
        id: img

        anchors.fill: parent
        source: {
            if (type == 0)
                return "./redball.png";
            else if (type == 1)
                return "./blueball.png";
            else
                return "./greenball.png";
        }
        opacity: 0

        Behavior on opacity {
            NumberAnimation { properties:"opacity"; duration: 200 }
        }
    }

    Particles {
        id: particles

        width: 1; height: 1
        anchors.centerIn: parent

        emissionRate: 0
        lifeSpan: 700; lifeSpanDeviation: 600
        angle: 0; angleDeviation: 360;
        velocity: 100; velocityDeviation: 30
        source: {
            if (type == 0)
                return "./redball.png";
            else if (type == 1)
                return "./blueball.png";
            else
                return "./greenball.png";
        }
    }

    states: [
        State {
            name: "AliveState"
            when: spawned == true && dying == false
            PropertyChanges { target: img; opacity: 1 }
        },

        State {
            name: "DeathState"
            when: dying == true
            StateChangeScript { script: particles.burst(50); }
            PropertyChanges { target: img; opacity: 0 }
            StateChangeScript { script: block.destroy(1000); }
        }
    ]
}
