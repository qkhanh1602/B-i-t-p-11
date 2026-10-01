package com.template.model;

import com.template.entity.Video_24110251;
import java.io.Serializable;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;

public class Cart_24110251 implements Serializable {
    private static final long serialVersionUID = 1L;

    public static final int DEFAULT_MAX_LIMIT = 10;
    public static final int DEFAULT_MIN_LIMIT = 1;

    public static final int RESULT_ADD_NEW = 1;
    public static final int RESULT_ADD_EXISTING = 2;
    public static final int RESULT_REACHED_MAX = 3;
    public static final int RESULT_UPDATED = 4;
    public static final int RESULT_REMOVED = 5;

    private final Map<String, CartItem_24110251> items = new LinkedHashMap<>();
    private int maxLimitPerItem = DEFAULT_MAX_LIMIT;

    public Cart_24110251() {
        this.maxLimitPerItem = DEFAULT_MAX_LIMIT;
    }

    public Cart_24110251(int maxLimitPerItem) {
        this.maxLimitPerItem = maxLimitPerItem > 0 ? maxLimitPerItem : DEFAULT_MAX_LIMIT;
    }

    /**
     * Thêm sản phẩm vào giỏ hàng
     * @param video Đối tượng video/sản phẩm
     * @param qty Số lượng cần thêm
     * @return mã kết quả (1: thêm mới, 2: tăng số lượng, 3: chạm giới hạn tối đa)
     */
    public int add(Video_24110251 video, int qty) {
        if (video == null || video.getVideoId() == null) return 0;
        String id = video.getVideoId();
        double price = video.getPrice();

        if (items.containsKey(id)) {
            CartItem_24110251 existing = items.get(id);
            int newQty = existing.getQuantity() + qty;
            if (newQty >= maxLimitPerItem) {
                existing.setQuantity(maxLimitPerItem);
                return RESULT_REACHED_MAX;
            } else {
                existing.setQuantity(newQty);
                return RESULT_ADD_EXISTING;
            }
        } else {
            int initialQty = Math.max(DEFAULT_MIN_LIMIT, Math.min(qty, maxLimitPerItem));
            items.put(id, new CartItem_24110251(video, initialQty, price, maxLimitPerItem));
            if (qty >= maxLimitPerItem) {
                return RESULT_REACHED_MAX;
            }
            return RESULT_ADD_NEW;
        }
    }

    /**
     * Sửa/thay đổi số lượng trong giới hạn [1, maxLimitPerItem]
     * @param videoId Mã video
     * @param qty Số lượng mới
     * @return mã kết quả (4: cập nhật thành công, 3: chạm giới hạn tối đa, 5: xóa nếu <= 0)
     */
    public int update(String videoId, int qty) {
        if (videoId == null || !items.containsKey(videoId)) return 0;
        if (qty <= 0) {
            items.remove(videoId);
            return RESULT_REMOVED;
        }

        CartItem_24110251 item = items.get(videoId);
        if (qty >= maxLimitPerItem) {
            item.setQuantity(maxLimitPerItem);
            return RESULT_REACHED_MAX;
        } else {
            item.setQuantity(qty);
            return RESULT_UPDATED;
        }
    }

    /**
     * Tăng số lượng lên 1 trong giới hạn cho phép
     */
    public boolean increase(String videoId) {
        if (videoId == null || !items.containsKey(videoId)) return false;
        CartItem_24110251 item = items.get(videoId);
        if (item.getQuantity() < maxLimitPerItem) {
            item.setQuantity(item.getQuantity() + 1);
            return true;
        }
        return false; // Đã đạt giới hạn tối đa
    }

    /**
     * Giảm số lượng xuống 1 trong giới hạn (nếu <= 0 thì tự động xóa)
     */
    public boolean decrease(String videoId) {
        if (videoId == null || !items.containsKey(videoId)) return false;
        CartItem_24110251 item = items.get(videoId);
        int newQty = item.getQuantity() - 1;
        if (newQty <= 0) {
            items.remove(videoId);
            return true;
        } else {
            item.setQuantity(newQty);
            return true;
        }
    }

    /**
     * Xóa 1 sản phẩm khỏi giỏ hàng
     */
    public void remove(String videoId) {
        if (videoId != null) {
            items.remove(videoId);
        }
    }

    /**
     * Làm trống giỏ hàng
     */
    public void clear() {
        items.clear();
    }

    public Collection<CartItem_24110251> getItems() {
        return items.values();
    }

    public int getTotalItems() {
        int total = 0;
        for (CartItem_24110251 item : items.values()) {
            total += item.getQuantity();
        }
        return total;
    }

    public int getTotalQuantity() {
        return getTotalItems();
    }

    public double getTotalAmount() {
        double total = 0;
        for (CartItem_24110251 item : items.values()) {
            total += item.getTotalPrice();
        }
        return total;
    }

    public boolean isEmpty() {
        return items.isEmpty();
    }

    public int getMaxLimitPerItem() {
        return maxLimitPerItem;
    }

    public void setMaxLimitPerItem(int maxLimitPerItem) {
        this.maxLimitPerItem = maxLimitPerItem;
    }
}
