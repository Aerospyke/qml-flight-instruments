set(QT_PACKAGES
        Gui
        Quick
        Graphs
        ShaderTools
        QuickLayouts
        QuickControls2
)

# The demo application itself has almost no resources; all QML, fonts and
# images for the instruments come from linking qml_flight_instruments.
# We deliberately do not list a resource file here so the generic setup
# does not try to add a non-existent one. The three "*RootDisplay.qml"
# files are registered by the instruments library under qrc:/qml/...
set(APPLICATION_RESOURCE_DECLARATION_FILE "")

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