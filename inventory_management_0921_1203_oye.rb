# 代码生成时间: 2025-09-21 12:03:25
# inventory_management.rb

# 库存管理系统
class InventoryManagement
  # 初始化库存管理系统
  def initialize
    @inventory = {}
  end

  # 添加一个新的库存项
  # @param item_name [String] 库存项名称
  # @param quantity [Integer] 库存数量
  def add_item(item_name, quantity)
    if quantity <= 0
      raise ArgumentError, 'Quantity must be greater than zero'
    end
    @inventory[item_name] = quantity
  end

  # 更新库存项的数量
  # @param item_name [String] 库存项名称
  # @param quantity [Integer] 新的库存数量
  def update_quantity(item_name, quantity)
    if quantity <= 0
      raise ArgumentError, 'Quantity must be greater than zero'
    end
    if @inventory.key?(item_name)
      @inventory[item_name] = quantity
    else
      raise KeyError, "Item '#{item_name}' not found in inventory"
    end
  end

  # 获取库存项的数量
  # @param item_name [String] 库存项名称
  def get_quantity(item_name)
    if @inventory.key?(item_name)
      @inventory[item_name]
    else
      raise KeyError, "Item '#{item_name}' not found in inventory"
    end
  end

  # 删除库存项
  # @param item_name [String] 库存项名称
  def remove_item(item_name)
    if @inventory.key?(item_name)
      @inventory.delete(item_name)
    else
      raise KeyError, "Item '#{item_name}' not found in inventory"
    end
  end

  # 打印当前库存状态
  def print_inventory
    puts 'Current Inventory:'
    @inventory.each do |item_name, quantity|
      puts "Item: #{item_name}, Quantity: #{quantity}"
    end
  end
end

# 示例用法
inventory = InventoryManagement.new
begin
  inventory.add_item('Apple', 10)
  inventory.add_item('Banana', 20)
  puts inventory.get_quantity('Apple')
  inventory.update_quantity('Apple', 15)
  inventory.print_inventory
rescue ArgumentError, KeyError => e
  puts "Error: #{e.message}"
end