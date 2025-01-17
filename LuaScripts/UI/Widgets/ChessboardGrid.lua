local EColor = CS.Beyond.Gameplay.EColor
local UIWidgetBase = require_ex('Common/Core/UIWidgetBase')
ChessboardGrid = HL.Class('ChessboardGrid', UIWidgetBase)
ChessboardGrid.m_gridInfo = HL.Field(HL.Table)
ChessboardGrid.m_puzzleGame = HL.Field(HL.Userdata)
ChessboardGrid._OnFirstTimeInit = HL.Override() << function(self)
end
ChessboardGrid.InitChessboardGrid = HL.Method(HL.Table, HL.Function, HL.Function, HL.Function) << function(self, gridInfo, dropFunc, pointerEnterFunc, pointerExitFunc)
    self:_FirstTimeInit()
    local banned = gridInfo.state == EColor.Banned
    local normal = gridInfo.state == EColor.Clear
    self.view.normalNode.gameObject:SetActiveIfNecessary(normal)
    self.view.emptyNode.gameObject:SetActiveIfNecessary(banned)
    self.view.preNode.gameObject:SetActiveIfNecessary(not normal and not banned)
    if not normal and not banned then
        self.view.preNode.color = UIUtils.getPuzzleColorByColorType(gridInfo.state)
    end
    self.view.chessboardDrop.onDropEvent:RemoveAllListeners()
    self.view.chessboardDrop.onDropEvent:AddListener(function(eventData)
        if dropFunc then
            dropFunc()
        end
    end)
    self.view.chessboardDrop.onPointerEnterEvent:RemoveAllListeners()
    self.view.chessboardDrop.onPointerEnterEvent:AddListener(function(eventData)
        if pointerEnterFunc then
            pointerEnterFunc()
        end
    end)
    self.view.chessboardDrop.onPointerExitEvent:RemoveAllListeners()
    self.view.chessboardDrop.onPointerExitEvent:AddListener(function(eventData)
        if pointerExitFunc then
            pointerExitFunc()
        end
    end)
    self.m_gridInfo = gridInfo
    self:SetHighlight(false)
end
ChessboardGrid.SetHighlight = HL.Method(HL.Boolean) << function(self, on)
    self.view.highlight.gameObject:SetActiveIfNecessary(on)
end
HL.Commit(ChessboardGrid)
return ChessboardGrid