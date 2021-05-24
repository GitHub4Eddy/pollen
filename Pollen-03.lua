-- QuickApp POLLEN

-- This QuickApp gives access to real-time pollen count - tree, grass and weed, of any location in Asia, Europe, North America, Australia and New Zealand by latitude and longitude. 

-- Pollen is a fine powder produced by trees and plants. 
-- Pollen can severely affect people, especially those with different ailments such as asthma and respiratory issues. 
-- It can aggravate these existing conditions or cause these issues in high risk groups.

-- Grass Pollen:	Pollen grains from grasses. Measuring unit is pollen particles/m³
-- Tree Pollen:	Pollen from trees such as Birch and Oak. Measuring unit is pollen particles/m³

-- The QuickApp provides a risk evaluation with levels 
   -- Low - Mild risk to those with severe respiratory issues. No risk for the general public 
   -- Moderate - Risky for those with severe respiratory problems. Mild risk for the general public 
   -- High - Risky for all groups of people 
   -- Very High - Highly risky for all groups of people

-- IMPORTANT
-- You need an API key form https://www.getambee.com
-- The API is free up to 100 API calls/day, with zero limitations on country, access to air quality, pollen, weather and fire data and dedicated support 


-- Version 0.3 (24th May 2021)
-- Changed handling in case exhausted daily usage limit 
-- Some minor changes

-- Version 0.1 (8th May 2021)
-- Initial version


-- Variables (mandatory): 
-- apiKey = Get your free API key from https://www.getambee.com
-- interval = [number] in seconds time to get the data from the API
-- timeout = [number] in seconds for http timeout
-- debugLevel = Number (1=some, 2=few, 3=all, 4=simulation mode) (default = 1)
-- icon = [numbber] User defined icon number (add the icon via an other device and lookup the number)

-- Example response:
-- {"message": "Success","lat": 52.10,"lng": 5.17,"data": [{"Count": {"grass_pollen": 23,"tree_pollen": 172,"weed_pollen": 1},"Risk": {"grass_pollen": "Low","tree_pollen": "Moderate","weed_pollen": "Low"},"Species": {"Grass": {"Grass / Poaceae": 23},"Others": 4,"Tree": {"Alder": 3,"Birch": 61,"Cypress": 6,"Elm": 1,"Hazel": 0,"Oak": 44,"Pine": 29,"Plane": 20,"Poplar / Cottonwood": 5},"Weed": {"Chenopod": 0,"Mugwort": 0,"Nettle": 0,"Ragweed": 0}},"updatedAt": "2021-05-08T11:14:38.000Z"}]}


-- No editing of this code is needed 


class 'CountGrassPollen'(QuickAppChild)
function CountGrassPollen:__init(dev)
  QuickAppChild.__init(self,dev)
  --self:trace("CountGrassPollen initiated, deviceId:",self.id)
end
function CountGrassPollen:updateValue(data) 
  --self:debug("CountGrassPollen: ",data.CountGrassPollen)
  self:updateProperty("value",tonumber(data.CountGrassPollen))
  self:updateProperty("unit", "p/m³")
  self:updateProperty("log", data.RiskGrassPollen .." risk")
end

class 'CountTreePollen'(QuickAppChild)
function CountTreePollen:__init(dev)
  QuickAppChild.__init(self,dev)
  --self:trace("CountTreePollen initiated, deviceId:",self.id)
end
function CountTreePollen:updateValue(data) 
  self:updateProperty("value",tonumber(data.CountTreePollen)) 
  self:updateProperty("unit", "p/m³")
  self:updateProperty("log", data.RiskTreePollen .." risk")
end

class 'CountWeedPollen'(QuickAppChild)
function CountWeedPollen:__init(dev)
  QuickAppChild.__init(self,dev)
  --self:trace("CountWeedPollen initiated, deviceId:",self.id)
end
function CountWeedPollen:updateValue(data) 
  self:updateProperty("value",tonumber(data.CountWeedPollen)) 
  self:updateProperty("unit", "p/m³")
  self:updateProperty("log", data.RiskWeedPollen .." risk")
end


-- QuickApp functions


local function getChildVariable(child,varName)
  for _,v in ipairs(child.properties.quickAppVariables or {}) do
    if v.name==varName then return v.value end
  end
  return ""
end


function QuickApp:logging(level,text) -- Logging function for debug
  if tonumber(debugLevel) >= tonumber(level) then 
      self:debug(text)
  end
end


function QuickApp:updateProperties() --Update properties
  self:logging(3,"updateProperties")
  self:updateProperty("log", data.timestamp)
end


function QuickApp:updateLabels() -- Update labels
  self:logging(3,"updateLabels")
  local labelText = ""
  if debugLevel == 4 then
    labelText = labelText .."SIMULATION MODE" .."\n\n"
  end
  labelText = labelText .."Grass Pollen: " ..data.CountGrassPollen .." p/m³ (" ..data.RiskGrassPollen .." risk)" .."\n"
  labelText = labelText .."Tree Pollen:  " ..data.CountTreePollen .." p/m³ (" ..data.RiskTreePollen .." risk)" .."\n"
  labelText = labelText .."Weed Pollen: " ..data.CountWeedPollen .." p/m³ (" ..data.RiskWeedPollen .." risk)" .."\n\n"
  labelText = labelText .."Grass: " .."\n"
  labelText = labelText .."Poaceae: " ..data.SpeciesGrassPoaceae .." p/m³" .."\n\n"
  labelText = labelText .."Tree: " .."\n"
  labelText = labelText .."Alder: " ..data.SpeciesTreeAlder .." p/m³" .."\n"
  labelText = labelText .."Birch: " ..data.SpeciesTreeBirch .." p/m³" .."\n"
  labelText = labelText .."Cypress: " ..data.SpeciesTreeCypress .." p/m³" .."\n"
  labelText = labelText .."Elm: " ..data.SpeciesTreeElm .." p/m³" .."\n"
  labelText = labelText .."Hazel: " ..data.SpeciesTreeHazel .." p/m³" .."\n"
  labelText = labelText .."Oak: " ..data.SpeciesTreeOak .." p/m³" .."\n"
  labelText = labelText .."Pine: " ..data.SpeciesTreePine .." p/m³" .."\n"
  labelText = labelText .."Plane: " ..data.SpeciesTreePlane .." p/m³" .."\n"
  labelText = labelText .."Poplar/Cottonwood: " ..data.SpeciesTreePoplarCottonwood .." p/m³" .."\n\n"
  labelText = labelText .."Weed: " .."\n"
  labelText = labelText .."Chenopod : " ..data.SpeciesWeedChenopod .." p/m³" .."\n"
  labelText = labelText .."Mugwort: " ..data.SpeciesWeedMugwort .." p/m³" .."\n"
  labelText = labelText .."Nettle: " ..data.SpeciesWeedNettle .." p/m³" .."\n"
  labelText = labelText .."Ragweed: " ..data.SpeciesWeedRagweed .." p/m³" .."\n\n"
  labelText = labelText .."Others: " ..data.SpeciesOthers .." p/m³" .."\n\n"
  labelText = labelText .."LAT: " ..latitude .." / " .."LON: " ..longitude .."\n"
  labelText = labelText .."Measured: " ..data.timestamp .."\n"
  
  self:logging(2,"labelText: " ..labelText)
  self:updateView("label1", "text", labelText) 
end


function QuickApp:getValues() -- Get the values
  self:logging(3,"getValues")
  data.CountGrassPollen = jsonTable.data[1].Count.grass_pollen 
  data.CountTreePollen = jsonTable.data[1].Count.tree_pollen
  data.CountWeedPollen = jsonTable.data[1].Count.weed_pollen
  data.RiskGrassPollen = jsonTable.data[1].Risk.grass_pollen 
  data.RiskTreePollen = jsonTable.data[1].Risk.tree_pollen
  data.RiskWeedPollen = jsonTable.data[1].Risk.weed_pollen
  data.SpeciesGrassPoaceae = jsonTable.data[1].Species.Grass.GrassPoaceae
  data.SpeciesTreeAlder = jsonTable.data[1].Species.Tree.Alder
  data.SpeciesTreeBirch = jsonTable.data[1].Species.Tree.Birch
  data.SpeciesTreeCypress = jsonTable.data[1].Species.Tree.Cypress
  data.SpeciesTreeElm = jsonTable.data[1].Species.Tree.Elm
  data.SpeciesTreeHazel = jsonTable.data[1].Species.Tree.Hazel
  data.SpeciesTreeOak = jsonTable.data[1].Species.Tree.Oak
  data.SpeciesTreePine = jsonTable.data[1].Species.Tree.Pine
  data.SpeciesTreePlane = jsonTable.data[1].Species.Tree.Plane
  data.SpeciesTreePoplarCottonwood = jsonTable.data[1].Species.Tree.PoplarCottonwood
  data.SpeciesWeedChenopod = jsonTable.data[1].Species.Weed.Chenopod
  data.SpeciesWeedMugwort = jsonTable.data[1].Species.Weed.Mugwort
  data.SpeciesWeedNettle = jsonTable.data[1].Species.Weed.Nettle
  data.SpeciesWeedRagweed = jsonTable.data[1].Species.Weed.Ragweed
  data.SpeciesOthers = jsonTable.data[1].Species.Others
  local updatedAt = jsonTable.data[1].updatedAt
  
    -- Check timezone and daylight saving time
  local timezone = os.difftime(os.time(), os.time(os.date("!*t",os.time())))/3600
  if os.date("*t").isdst then -- Check daylight saving time 
    timezone = timezone + 1
  end
  self:logging(3,"Timezone + dst: " ..timezone)

  -- Convert time of measurement to local timezone
  local pattern = "(%d+)-(%d+)-(%d+) (%d+):(%d+):(%d+)"
  updatedAt = updatedAt:gsub("%.000Z", "") -- Clean up date/time
  updatedAt = updatedAt:gsub("%T", " ") -- Clean up date/time
  local runyear, runmonth, runday, runhour, runminute, runseconds = updatedAt:match(pattern)
  local convertedTimestamp = os.time({year = runyear, month = runmonth, day = runday, hour = runhour, min = runminute, sec = runseconds})
  data.timestamp = os.date("%d-%m-%Y %X", convertedTimestamp + (timezone*3600))
end


function QuickApp:simData() -- Simulate Ambee API
  self:logging(3,"Simulation mode")
  local apiResult = '{"message": "Success","lat": 52.10,"lng": 5.17,"data": [{"Count": {"grass_pollen": 23,"tree_pollen": 172,"weed_pollen": 1},"Risk": {"grass_pollen": "Low","tree_pollen": "Moderate","weed_pollen": "Low"},"Species": {"Grass": {"Grass / Poaceae": 23},"Others": 4,"Tree": {"Alder": 3,"Birch": 61,"Cypress": 6,"Elm": 1,"Hazel": 0,"Oak": 44,"Pine": 29,"Plane": 20,"Poplar / Cottonwood": 5},"Weed": {"Chenopod": 0,"Mugwort": 0,"Nettle": 0,"Ragweed": 0}},"updatedAt": "2021-05-08T11:14:38.000Z"}]}'
  
  self:logging(3,"apiResult: " ..apiResult)
  apiResult = apiResult:gsub("% / ", "") -- Clean up the apiResult by removing /
  self:logging(3,"apiResult editted: " ..apiResult)

  jsonTable = json.decode(apiResult) -- Decode the json string from api to lua-table 
  
  self:getValues()
  self:updateLabels()
  self:updateProperties()

  for id,child in pairs(self.childDevices) do 
    child:updateValue(data) 
  end
  
  self:logging(3,"SetTimeout " ..interval .." seconds")
  fibaro.setTimeout(interval*1000, function() 
     self:simData()
  end)
end


function QuickApp:getData()
  self:logging(3,"Start getData")
  self:logging(2,"URL: " ..address)
    
  http:request(address, {
    options = {data = Method, method = "GET", headers = {["x-api-key"] = apiKey,["Content-Type"] = "application/json",["Accept"] = "application/json",}},
    
      success = function(response)
        self:logging(3,"response status: " ..response.status)
        self:logging(3,"headers: " ..response.headers["Content-Type"])
        self:logging(2,"Response data: " ..response.data)

        if response.data == nil or response.data == "" or response.data == "[]" or response.status > 200 then -- Check for empty result
          self:warning("Temporarily no data from Ambee")
          self:warning(response.data)
          return
          --self:logging(3,"No data SetTimeout " ..interval .." seconds")
          --fibaro.setTimeout(interval*1000, function() 
          --  self:getdata()
          --end)
        end

        response.data = response.data:gsub("% / ", "") -- Clean up the response.data by removing /
        self:logging(2,"Response data editted: " ..response.data)

        jsonTable = json.decode(response.data) -- JSON decode from api to lua-table

        self:getValues()
        self:updateLabels()
        self:updateProperties()

        for id,child in pairs(self.childDevices) do 
          child:updateValue(data) 
        end
      
      end,
      error = function(error)
        self:error('error: ' ..json.encode(error))
        self:updateProperty("log", "error: " ..json.encode(error))
      end
    }) 

  self:logging(3,"SetTimeout " ..interval .." seconds")
  fibaro.setTimeout((interval)*1000, function() 
     self:getData()
  end)
end


function QuickApp:createVariables() -- Get all Quickapp Variables or create them
  data = {}
  data.CountGrassPollen = "0"
  data.CountTreePollen = "0"
  data.CountWeedPollen = "0"
  data.RiskGrassPollen = "n/a"
  data.RiskTreePollen = "n/a"
  data.RiskWeedPollen = "n/a"
  data.SpeciesGrassPoaceae = "0"
  data.SpeciesTreeAlder = "0"
  data.SpeciesTreeBirch = "0"
  data.SpeciesTreeCypress = "0"
  data.SpeciesTreeElm = "0"
  data.SpeciesTreeHazel = "0"
  data.SpeciesTreeOak = "0"
  data.SpeciesTreePine = "0"
  data.SpeciesTreePlane = "0"
  data.SpeciesTreePoplarCottonwood = "0"
  data.SpeciesWeedChenopod = "0"
  data.SpeciesWeedMugwort = "0"
  data.SpeciesWeedNettle = "0"
  data.SpeciesWeedRagweed = "0"
  data.SpeciesOthers = "0"
  data.timestamp = ""
end


function QuickApp:getQuickAppVariables() -- Get all variables 
  apiKey = self:getVariable("apiKey")
  latitude = tonumber(self:getVariable("latitude"))
  longitude = tonumber(self:getVariable("longitude"))
  interval = tonumber(self:getVariable("interval")) 
  httpTimeout = tonumber(self:getVariable("httpTimeout")) 
  debugLevel = tonumber(self:getVariable("debugLevel"))
  local icon = tonumber(self:getVariable("icon")) 

  if apiKey =="" or apiKey == nil then
    apiKey = "" 
    self:setVariable("apiKey",apiKey)
    self:trace("Added QuickApp variable apiKey")
  end
  if latitude == 0 or latitude == nil then 
    latitude = string.format("%.2f",api.get("/settings/location")["latitude"]) -- Default latitude of your HC3
    self:setVariable("latitude", latitude)
    self:trace("Added QuickApp variable latitude with default value " ..latitude)
  end  
  if longitude == 0 or longitude == nil then
    longitude = string.format("%.2f",api.get("/settings/location")["longitude"]) -- Default longitude of your HC3
    self:setVariable("longitude", longitude)
    self:trace("Added QuickApp variable longitude with default value " ..longitude)
  end
  if interval == "" or interval == nil then
    interval = "1200" -- Free account includes up to 100 calls a day, so default value is 1200 (every 20 minutes)
    self:setVariable("interval",interval)
    self:trace("Added QuickApp variable interval")
    interval = tonumber(interval)
  end  
  if httpTimeout == "" or httpTimeout == nil then
    httpTimeout = "5" -- timeoout in seconds
    self:setVariable("httpTimeout",httpTimeout)
    self:trace("Added QuickApp variable httpTimeout")
    httpTimeout = tonumber(httpTimeout)
  end
  if debugLevel == "" or debugLevel == nil then
    debugLevel = "1" -- Default value for debugLevel response in seconds
    self:setVariable("debugLevel",debugLevel)
    self:trace("Added QuickApp variable debugLevel")
    debugLevel = tonumber(debugLevel)
  end
  if icon == "" or icon == nil then 
    icon = "0" -- Default icon
    self:setVariable("icon",icon)
    self:trace("Added QuickApp variable icon")
    icon = tonumber(icon)
  end
  if icon ~= 0 then 
    self:updateProperty("deviceIcon", icon) -- set user defined icon 
  end
  latitude = string.format("%.2f",latitude) -- double check, to prevent 404 response
  longitude = string.format("%.2f",longitude) -- double check, to prevent 404 response

  address = "https://api.ambeedata.com/latest/pollen/by-lat-lng" .."?lat=" ..latitude .."&lng=" ..longitude -- Combine webaddress and location info (current measurement)

  if apiKey == nil or apiKey == ""  then -- Check mandatory API key 
    self:error("API key is empty! Get your free API key from https://www.getambee.com")
    self:warning("No API Key: Switched to Simulation Mode")
    debugLevel = 4 -- Simulation mode due to empty API key
  end

end


function QuickApp:setupChildDevices()
  local cdevs = api.get("/devices?parentId="..self.id) or {} -- Pick up all my children 
  function self:initChildDevices() end -- Null function, else Fibaro calls it after onInit()...

  if #cdevs==0 then -- No children, create children
    local initChildData = { 
      {className="CountGrassPollen", name="Grass Pollen", type="com.fibaro.multilevelSensor", value=0},
      {className="CountTreePollen", name="Tree Pollen", type="com.fibaro.multilevelSensor", value=0},
      {className="CountWeedPollen", name="Weed Pollen", type="com.fibaro.multilevelSensor", value=0},
    }
    for _,c in ipairs(initChildData) do
      local child = self:createChildDevice(
        {name = c.name,
          type=c.type,
          value=c.value,
          unit=c.unit,
          initialInterfaces = {}, 
        },
        _G[c.className] -- Fetch class constructor from class name
      )
      child:setVariable("className",c.className)  -- Save class name so we know when we load it next time
    end   
  else 
    for _,child in ipairs(cdevs) do
      local className = getChildVariable(child,"className") -- Fetch child class name
      local childObject = _G[className](child) -- Create child object from the constructor name
      self.childDevices[child.id]=childObject
      childObject.parent = self -- Setup parent link to device controller 
    end
  end
end


function QuickApp:onInit()
  __TAG = fibaro.getName(plugin.mainDeviceId) .." ID:" ..plugin.mainDeviceId
  self:debug("onInit") 
  
  self:setupChildDevices() -- Setup the Child Devices
  self:getQuickAppVariables() -- Get Quickapp Variables or create them
  self:createVariables() -- Create Variables

  http = net.HTTPClient({timeout=httpTimeout*1000})

  if tonumber(debugLevel) >= 4 then 
    self:simData() -- Go in simulation
  else
    self:getData() -- Get data from API
  end
end

--EOF
