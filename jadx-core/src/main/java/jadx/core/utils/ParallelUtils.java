package jadx.core.utils;

import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.atomic.AtomicReference;
import java.util.function.Consumer;

import jadx.core.dex.nodes.ClassNode;
import jadx.core.utils.exceptions.JadxRuntimeException;
import jadx.core.utils.tasks.TaskExecutor;

/**
 * Small helper for bounded parallel loops in the analysis pipeline.
 * Uses a dedicated thread pool per call (same pattern as
 * {@link jadx.core.utils.tasks.TaskExecutor}).
 */
public final class ParallelUtils {

	public static final int MIN_ITEMS_FOR_PARALLEL = 4;

	private ParallelUtils() {
	}

	public static void forEachClass(List<ClassNode> classes, int threads, Consumer<ClassNode> action) {
		forEach(classes, threads, action);
	}

	public static <T> void forEach(List<T> items, int threads, Consumer<T> action) {
		if (items.isEmpty()) {
			return;
		}
		if (threads <= 1 || items.size() < MIN_ITEMS_FOR_PARALLEL) {
			for (T item : items) {
				Utils.checkThreadInterrupt();
				action.accept(item);
			}
			return;
		}
		int poolSize = Math.min(threads, items.size());
		ExecutorService executor = Executors.newFixedThreadPool(poolSize, Utils.simpleThreadFactory("jadx-pre-"));
		AtomicReference<Throwable> error = new AtomicReference<>();
		for (T item : items) {
			executor.execute(() -> {
				if (error.get() != null) {
					return;
				}
				try {
					Utils.checkThreadInterrupt();
					action.accept(item);
				} catch (Throwable e) {
					error.compareAndSet(null, e);
				}
			});
		}
		executor.shutdown();
		TaskExecutor.awaitExecutorTermination(executor);
		Throwable err = error.get();
		if (err != null) {
			if (err instanceof RuntimeException) {
				throw (RuntimeException) err;
			}
			throw new JadxRuntimeException("Parallel execution failed", err);
		}
	}
}
