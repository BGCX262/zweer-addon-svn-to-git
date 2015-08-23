InstanceLog = CreateFrame( "Frame" );
InstanceLog:RegisterEvent( "PLAYER_ENTERING_WORLD" );
InstanceLog:SetScript( "OnEvent", function( self, event )
    if( event == "PLAYER_ENTERING_WORLD" ) then
        self:EnteringWorld();
    end
end );

InstanceLog.Print = function( self, message )
    DEFAULT_CHAT_FRAME:AddMessage( message );
end

InstanceLog.EnteringWorld = function( self )
    local _, instanceType = IsInInstance();
    if ( instanceType == "raid" ) then
        if ( not LoggingCombat() ) then
            LoggingCombat( true );
            self:Print( "Combat log enabled" );
        else
            --self:Print( "Combat log is already enabled" );
        end
    else
        if ( LoggingCombat() ) then
            LoggingCombat( false );
            self:Print( "Combat log disabled" );
        else
            --self:Print( "Combat log is already disabled" );
        end
    end
end