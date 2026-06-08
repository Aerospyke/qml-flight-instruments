set(QT_PACKAGES
        Gui
        Quick
        Graphs
        ShaderTools
        QuickLayouts
        QuickControls2
)

# The demo now has a small resource file of its own (the single modern
# root window QML). All the actual instrument components, images and fonts
# still come from linking qml_flight_instruments (the modern module).
set(APPLICATION_RESOURCE_DECLARATION_FILE
        ui/demo.qrc)

set(APPLICATION_SOURCE_FILES
        src/cpp/animation.cpp
        src/cpp/main.cpp
)

set(APPLICATION_HEADER_FILES
        src/include/animation.h
)

set(APPLICATION_INCLUDE_DIRECTORIES
        src/include)

set(LINKED_LIBRARIES_INTERNAL
        qml_flight_instruments
)

set(LINKED_LIBRARIES_QT
        Qt::Core
        Qt::Gui
        Qt::Quick
        Qt::Graphs
        Qt::ShaderTools
        Qt::QuickLayouts
        Qt::QuickControls2
)

find_and_setup_qt(COMPONENTS ${QT_PACKAGES}
        VERSION ${QT_VERSION_TO_USE}
        APPLICATION_NAME ${APPLICATION_NAME}
        APPLICATION_URI ${APPLICATION_URI}
        APPLICATION_BUNDLE_GUI_ID ${APPLICATION_BUNDLE_GUI_ID}
        APPLICATION_ICON_PATH ${APPLICATION_ICON_PATH}
        APPLICATION_RESOURCE_DECLARATION_FILE ${APPLICATION_RESOURCE_DECLARATION_FILE}
        APPLICATION_SOURCE_FILES ${APPLICATION_SOURCE_FILES}
        APPLICATION_HEADER_FILES ${APPLICATION_HEADER_FILES}
        APPLICATION_INCLUDE_DIRECTORIES ${APPLICATION_INCLUDE_DIRECTORIES}
        LINKED_LIBRARIES_INTERNAL ${LINKED_LIBRARIES_INTERNAL}
        LINKED_LIBRARIES_QT ${LINKED_LIBRARIES_QT})