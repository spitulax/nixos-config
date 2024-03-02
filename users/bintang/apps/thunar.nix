{ pkgs
, ...
}: {
  home.file.".config/xfce4/xfconf/xfce-perchannel-xml/thunar.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>

    <channel name="thunar" version="1.0">
      <property name="last-icon-view-zoom-level" type="string" value="THUNAR_ZOOM_LEVEL_100_PERCENT"/>
      <property name="last-view" type="string" value="ThunarIconView"/>
      <property name="last-window-maximized" type="bool" value="true"/>
      <property name="misc-single-click" type="bool" value="false"/>
      <property name="last-separator-position" type="int" value="170"/>
      <property name="misc-directory-specific-settings" type="bool" value="true"/>
      <property name="last-show-hidden" type="bool" value="true"/>
      <property name="last-location-bar" type="string" value="ThunarLocationButtons"/>
      <property name="last-image-preview-visible" type="bool" value="true"/>
      <property name="last-toolbar-item-order" type="string" value="0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17"/>
      <property name="last-toolbar-visible-buttons" type="string" value="0,1,1,1,1,0,0,0,0,0,0,0,0,1,1,1,1,0"/>
      <property name="misc-middle-click-in-tab" type="bool" value="true"/>
      <property name="misc-show-delete-action" type="bool" value="true"/>
    </channel>
  '';
}
