package jadx.core.dex.visitors.usage;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.function.BiConsumer;

public class UseSet<K, V> {
	private final Map<K, Set<V>> useMap = new HashMap<>();

	public void add(K obj, V use) {
		if (obj == use) {
			// self excluded
			return;
		}
		Set<V> set = useMap.computeIfAbsent(obj, k -> new HashSet<>());
		set.add(use);
	}

	public Set<V> get(K obj) {
		return useMap.get(obj);
	}

	public Set<V> getOrDefault(K obj, Set<V> defaultValue) {
		return useMap.getOrDefault(obj, defaultValue);
	}

	public void visit(BiConsumer<K, Set<V>> consumer) {
		for (Map.Entry<K, Set<V>> entry : useMap.entrySet()) {
			consumer.accept(entry.getKey(), entry.getValue());
		}
	}

	public List<Map.Entry<K, Set<V>>> getEntries() {
		return new ArrayList<>(useMap.entrySet());
	}

	public void mergeFrom(UseSet<K, V> other) {
		for (Map.Entry<K, Set<V>> entry : other.useMap.entrySet()) {
			Set<V> set = useMap.computeIfAbsent(entry.getKey(), k -> new HashSet<>());
			set.addAll(entry.getValue());
		}
	}
}
